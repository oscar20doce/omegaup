{include file='redirect.tpl'}
{include file='head.tpl'}
{include file='mainmenu.tpl'}
{include file='status.tpl'}

<div class="panel panel-default">
	<div class="panel-body">
		<div class="bottom-margin">
			<a href="/problemcreate.php" class="btn btn-primary" id="problem-create">{#myproblemsListCreateProblem#}</a>
		</div>
		<div id="parent_problem_list">
			<div class="wait_for_ajax panel panel-default no-bottom-margin" id="problem_list">
				<div class="panel-heading">
					<h3 class="panel-title">{#myproblemsListMyProblems#}</h3>
				</div>
				<table class="table">
					<thead>
						<tr>
							<th>T&iacute;tulo</th>
							<th>P&uacute;blico</th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script>
	(function(){
		$(".navbar #nav-problems").addClass("active");
		
		function makeWorldClockLink(date) {
			try {
				return "http://timeanddate.com/worldclock/fixedtime.html?iso=" + date.toISOString();
			} catch (e) {
				return '#';
			}
		}
	
		omegaup.getMyProblems(function(problems) {
			// Got the contests, lets draw them
			var html = "";
			for (var i = 0; i < problems.results.length; i++) {
				html += "<tr>"
					+ "<td><b><a href='/arena/problem/" + problems.results[i].alias  + "/'>" + omegaup.escape(problems.results[i].title) + "</a></b></td>"										
					+ '<td>'+ ((problems.results[i].public == '1') ? 'Sí' : 'No')  + '</td>'
					+ '<td><a href="/problemedit.php?problem=' + problems.results[i].alias  + '">{#wordsEdit#}</a></td>'
					+ '<td><a href="/addproblemtocontest.php?problem=' + problems.results[i].alias  + '">{#myproblemsListAddContests#}</a></td>'					
					+ '<td><a href="/problemstats.php?problem=' + problems.results[i].alias  + '">Estadísticas</a></td>'
					+ "</tr>";
			}
			$("#problem_list").removeClass("wait_for_ajax")
			$("#problem_list tbody").empty().append(html);
		});
	})();
</script>
	
{include file='footer.tpl'}
