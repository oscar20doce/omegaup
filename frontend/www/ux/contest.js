$(document).ready(function() {
	var omegaup = new OmegaUp();
	var problems = {};
	var activeTab = 'problems';
	var currentProblem = null;
	var currentRanking = {};
	var currentEvents;
	var startTime = null;
	var finishTime = null;

	var contestAlias = 'prueba'; // /\/arena\/([^\/]+)\/?/.exec(window.location.pathname)[1];
	
	Highcharts.setOptions({
       global: {
          useUTC: false
       }
    });

	omegaup.getContest(contestAlias, function(contest) {
		$('#title .contest-title').html(contest.title);
		$('#summary .title').html(contest.title);
		$('#summary .description').html(contest.description);

		startTime = contest.start_time;
		finishTime = contest.finish_time;

		var letter = 65;

		for (var idx in contest.problems) {
			var problem = contest.problems[idx];
			var problemName = String.fromCharCode(letter) + '. ' + problem.title;

			problems[problem.alias] = problem;

			problem.letter = String.fromCharCode(letter);

			var prob = $('#problem-list .template').clone().removeClass('template').addClass('problem_' + problem.alias);
			$('.name', prob).attr('href', '#problems/' + problem.alias).html(problemName);
			$('#problem-list').append(prob);

			$('#clarification select').append('<option value="' + problem.alias + '">' + problemName + '</option>');

			$('<th colspan="2"><a href="#problems/' + problem.alias + '" title="' + problem.alias + '">' + String.fromCharCode(letter++) + '</a></th>').insertBefore('#ranking thead th.total');
			$('<td class="prob_' + problem.alias + '_points"></td>').insertBefore('#ranking tbody .template td.points');
			$('<td class="prob_' + problem.alias + '_penalty"></td>').insertBefore('#ranking tbody .template td.points');
		}

		omegaup.getRanking(contestAlias, rankingChange);
		setInterval(function() { omegaup.getRanking(contestAlias, rankingChange); }, 5 * 60 * 1000);

		omegaup.getClarifications(contestAlias, clarificationsChange);
		setInterval(function() { omegaup.getClarifications(contestAlias, clarificationsChange); }, 5 * 60 * 1000);

		updateClock();
		setInterval(updateClock, 1000);

		// Trigger the event (useful on page load).
		$(window).hashchange();

        	$('#loading').fadeOut('slow');
	        $('#root').fadeIn('slow');
	});

	$('#overlay, .close').click(function(e) {
		if (e.target.id === 'overlay' || e.target.className === 'close') {
			$('#overlay, #submit #clarification').hide();
			window.location.hash = window.location.hash.substring(0, window.location.hash.lastIndexOf('/'));
			return false;
		}
	});

	$('#submit').submit(function(e) {
		omegaup.submit(contestAlias, currentProblem.alias, $('#submit select[name="language"]').val(), $('#submit textarea[name="code"]').val(), function (run) {
			var r = $('#problem .run-list .template').clone().removeClass('template').addClass('added').attr('id', 'run_' + run.guid);
			$('.status', r).html('new');
			$('#problem .runs > tbody:last').after(r);
			currentProblem.runs.push(run);

			function updateRun(guid, orig_run) {
				setTimeout(function() {
					omegaup.runStatus(guid, function(run) {
						var r = $('#run_' + run.guid);

						orig_run.contest_score = run.contest_score;
						orig_run.status = run.status;
						orig_run.veredict = run.veredict;
						orig_run.submit_delay = run.submit_delay;
						orig_run.time = run.time;
						orig_run.language = run.language;

						$('.points', r).html(parseInt(run.contest_score).toFixed(2));
						$('.status', r).html(run.status == 'ready' ? run.veredict : run.status);
						$('.penalty', r).html(run.submit_delay);
						$('.time', r).html(Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', run.time.getTime()));
						$('.language', r).html(run.language);

						if (run.status == 'ready') {
							omegaup.getRanking(contestAlias, rankingChange);
						} else {
							updateRun(guid, orig_run);
						}
					});
				}, 5000);
			}

			updateRun(run.guid, run);

			$('#overlay').hide();
			window.location.hash = window.location.hash.substring(0, window.location.hash.lastIndexOf('/'));
		});

		return false;
	});

	$('#clarification').submit(function (e) {
		omegaup.newClarification(contestAlias, $('#clarification select[name="problem"]').val(), $('#clarification textarea[name="message"]').val(), function (run) {
			$('#overlay').hide();
			window.location.hash = window.location.hash.substring(0, window.location.hash.lastIndexOf('/'));
			omegaup.getClarifications(contestAlias, clarificationsChange);
		});

		return false;
	});

	$(window).hashchange(function(e) {
		var tabChanged = false;
		var tabs = ['summary', 'problems', 'ranking', 'clarifications'];

		for (var i = 0; i < 4; i++) {
			if (window.location.hash.indexOf('#' + tabs[i]) == 0) {
				tabChanged = activeTab != tabs[i];
				activeTab = tabs[i];

				break;
			}
		}

		var problem = /#problems\/([^\/]+)(\/new-run)?/.exec(window.location.hash);

		if (problem && problems[problem[1]]) {
			var newRun = problem[2];
			currentProblem = problem = problems[problem[1]];

			$('#problem-list .active').removeClass('active');
			$('#problem-list .problem_' + problem.alias).addClass('active');

			function update(problem) {
				$('#summary').hide();
				$('#problem').show();
				$('#problem > .title').html(problem.letter + '. ' + problem.title);
				$('#problem .data .points').html(problem.points);
				$('#problem .validator').html(problem.validator);
				$('#problem .time_limit').html(problem.time_limit / 1000 + "s");
				$('#problem .memory_limit').html(problem.memory_limit / 1024 + "MB");
				$('#problem .statement').html(problem.problem_statement);
				$('#problem .source span').html(problem.source);
				$('#problem .runs tfoot td a').attr('href', '#problems/' + problem.alias + '/new-run');

				$('#problem .run-list .added').remove();

				for (var idx in problem.runs) {
					if (!problem.runs.hasOwnProperty(idx)) continue;
					var run = problem.runs[idx];

					var r = $('#problem .run-list .template').clone().removeClass('template').addClass('added').attr('id', 'run_' + run.guid);
					$('.points', r).html(parseFloat(run.contest_score).toFixed(2));
					$('.status', r).html(run.status == 'ready' ? run.veredict : run.status);
					$('.penalty', r).html(run.submit_delay);
					if (run.time) {
						$('.time', r).html(Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', run.time.getTime()));
					}
					$('.language', r).html(run.language);
					$('#problem .runs > tbody:last').append(r);
				}

				MathJax.Hub.Queue(["Typeset", MathJax.Hub, $('#problem .statement').get(0)]);
			}

			if (problem.problem_statement) {
				update(problem);
			} else {
				omegaup.getProblem(contestAlias, problem.alias, function (problem_ext) {
					problem.source = problem_ext.source;
					problem.problem_statement = problem_ext.problem_statement;
					problem.runs = problem_ext.runs;
					update(problem);
				});
			}

			if (newRun) {
				$('#overlay form').hide();
				$('#submit').show();
				$('#overlay').show();
			}
		} else if (activeTab == 'problems') {
			$('#problem').hide();
			$('#summary').show();
			$('#problem-list .active').removeClass('active');
			$('#problem-list .summary').addClass('active');
		} else if (activeTab == 'clarifications') {
			if (window.location.hash == '#clarifications/new') {
				$('#overlay form').hide();
				$('#overlay, #clarification').show();
			}
		}

		if (tabChanged) {
			$('.tabs a.active').removeClass('active');
			$('.tabs a[href="#' + activeTab + '"]').addClass('active');
			$('.tab').hide();
			$('#' + activeTab).show();
			
			if (activeTab == 'ranking') {
                if (currentEvents) {
                    console.log('redrawing');
                    rankingEvents(currentEvents);
                }
            }
		}
		
	});

	function rankingEvents(data) {
        currentEvents = data;
        var dataInSeries = {};
        var navigatorData = [[startTime.getTime(), 0]];
        var series = [];
        
        // group points by person
        for (var i = 0, l = data.events.length; i < l; i++) {
            var curr = data.events[i];
            if (!dataInSeries[curr.name]) {
                dataInSeries[curr.name] = [[startTime.getTime(), 0]];
            }
            dataInSeries[curr.name].push([
                startTime.getTime() + curr.delta*60*1000,
                curr.total.points
            ]);
            
            // check if to add to navigator
            if (curr.total.points > navigatorData[navigatorData.length-1][1]) {
                navigatorData.push([
                    startTime.getTime() + curr.delta*60*1000,
                    curr.total.points
                ]);
            }
        }
        
        // convert datas to series
        for (var i in dataInSeries) {
            if (dataInSeries.hasOwnProperty(i)) {
                dataInSeries[i].push([Math.min(finishTime.getTime(), Date.now()), dataInSeries[i][dataInSeries[i].length - 1][1]]);
                series.push({
                    name: i,
                    data: dataInSeries[i],
                    step: true
                });
            }
        }
        navigatorData.push([Math.min(finishTime.getTime(), Date.now()), navigatorData[navigatorData.length - 1][1]]);
        
        // chart it!
        createChart(series, navigatorData);

        // now animated sort the ranking table!
        $("#ranking > table").sortTable({
            onCol: 1,
            keepRelationships: true,
            sortType: 'numeric'
        });
	}

	function rankingChange(data) {
		$('#mini-ranking tbody tr.inserted').remove();

		var ranking = data.ranking;
		var newRanking = {};

		for (var i = 0; i < ranking.length; i++) {
			var rank = ranking[i];
			newRanking[rank.name] = i;
            
            // new user, just add row at the end
			if (currentRanking[rank.name] === undefined) {
				currentRanking[rank.name] = $('#ranking tbody tr.inserted').length;
				$('#ranking tbody').append(
					$('#ranking tbody tr.template').clone().removeClass('template').addClass('inserted').addClass('rank-new')
				);
			}
            
            // update a user's row
			var r = $('#ranking tbody tr.inserted')[currentRanking[rank.name]];
			$('.position', r).html(i+1);
			$('.user', r).html(rank.name);

			for (var alias in rank.problems) {
				if (!rank.problems.hasOwnProperty(alias)) continue;
				
				$('.prob_' + alias + '_points', r).html(rank.problems[alias].points);
				$('.prob_' + alias + '_penalty', r).html(rank.problems[alias].penalty);

				if (rank.username == omegaup.username) {
					$('#problems .problem_' + alias + ' .solved').html("(" + rank.problems[alias].points + " / " + problems[alias].points + ")");
				}
			}
            
            // if rank went up, add a class
			if (parseInt($('.points', r)) < parseInt(rank.total.points)) {
				r.addClass('rank-up');
			}
            
			$('.points', r).html(rank.total.points);
			$('.penalty', r).html(rank.total.penalty);
            
            // update miniranking
			if (i < 10) {
				r = $('#mini-ranking tbody tr.template').clone().removeClass('template').addClass('inserted');

				$('.position', r).html(i+1);
				$('.user', r).html(rank.name);
				$('.points', r).html(rank.total.points);
				$('.penalty', r).html(rank.total.penalty);

				$('#mini-ranking tbody').append(r);
			}
		}

		currentRanking = newRanking;
		
		omegaup.getRankingEvents(contestAlias, rankingEvents);
	}
	
	function updateClock() {
		var date = new Date().getTime();
		var clock = "";

		if (date < startTime.getTime()) {
				clock = "-" + formatDelta(startTime.getTime() - (date + omegaup.deltaTime));
		} else if (date > finishTime.getTime()) {
				clock = "00:00:00";
		} else {
				clock = formatDelta(finishTime.getTime() - (date + omegaup.deltaTime));
		}

		$('#title .clock').html(clock);
	}

	function formatDelta(delta) {
		var days = Math.floor(delta / (24 * 60 * 60 * 1000));
		delta -= days * (24 * 60 * 60 * 1000);
		var hours = Math.floor(delta / (60 * 60 * 1000));
		delta -= hours * (60 * 60 * 1000);
		var minutes = Math.floor(delta / (60 * 1000));
		delta -= minutes * (60 * 1000);
		var seconds = Math.floor(delta / 1000);

		var clock = "";

		if (days > 0) {
			clock += days + ":";
		}
		if (hours < 10) clock += "0";
		clock += hours + ":";
		if (minutes < 10) clock += "0";
		clock += minutes + ":";
		if (seconds < 10) clock += "0";
		clock += seconds;

		return clock;
	}

	function clarificationsChange(data) {
		$('.clarifications tr.inserted').remove();

		for (var i = 0; i < data.clarifications.length; i++) {
			var clarification = data.clarifications[i];

			var r = $('.clarifications tbody tr.template').clone().removeClass('template').addClass('inserted');

			$('.problem', r).html(clarification.problem_alias);
			$('.time', r).html(clarification.time);
			$('.message', r).html(clarification.message);
			$('.answer', r).html(clarification.answer);

			$('.clarifications tbody').append(r);
		}
	}
	
	function createChart(series, navigatorSeries) {
        window.chart = new Highcharts.StockChart({
            chart: {
                renderTo: 'ranking-chart',
                height: 300,
                spacingTop: 20
            },

            xAxis: {
                ordinal: false,
                min: startTime.getTime(),
                max: Math.min(finishTime.getTime(), Date.now())
            },

            yAxis: {
                showLastLabel: true,
                showFirstLabel: false,
                min: 0,
                max: (function() {
                    var total = 0;
                    for (var prob in problems) {
                        if (problems.hasOwnProperty(prob)) {
                            total += parseInt(problems[prob].points, 10);
                        }
                    }
                    return total;
                })()
            },
            
            plotOptions: {
                series: {
                    lineWidth: 3,
                    states: {
                        hover: {
                            lineWidth: 3
                        }
                    },
                    marker: {
                        radius: 5,
                        symbol: 'circle',
                        lineWidth: 1
                    }
                }
            },

            navigator: {
                series: {
                    type: 'line',
                    step: true,
                    lineWidth: 3,
                    lineColor: '#333',
                    data: navigatorSeries
                }
            },

            rangeSelector: {
                enabled: false
            },
            
            series: series
        });
        
        // set legend colors
        console.log('adding colors');
        console.log(window.chart.series);
        for (var name in currentRanking) {
            console.log(name);
            if (currentRanking.hasOwnProperty(name)) {
                var r = $('#ranking tbody tr.inserted')[currentRanking[name]];
                var color = (function () {
                    for (var i = 0; i < window.chart.series.length; i++) {
                        if (window.chart.series[i].name === name) {
                            return window.chart.series[i].color;
                        }
                    }
                })();
                
                $('.legend', r).css({
                    'background-color': color || 'transparent'
                });
            }
        }
    }
});