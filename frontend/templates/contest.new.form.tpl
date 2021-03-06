{if !isset($IS_UPDATE)}
	{assign "IS_UPDATE" 0}
{/if}


<div class="panel panel-primary	">
	<div class="panel-heading">
		<h3 class="panel-title">
			{if $IS_UPDATE neq 1}
				Nuevo concurso
			{else}
				Editar concurso
			{/if}
		</h3>
	</div>
	<div class="panel-body">
		{if $IS_UPDATE neq 1}
		<div class="btn-group bottom-margin">
			<button class="btn btn-default" id='omi' name='omi'>Estilo OMI - IOI</button>
			<button class="btn btn-default" id='preioi' name='preioi'>{#contestNewForm#}</button>
			<button class="btn btn-default" id='conacup' name='conacup'>{#contestNewFormConacupStyle#}</button>
		</div>		
		{/if}
		<form class="new_contest_form">
				{if $IS_UPDATE eq 1}
					<div class="row">
						<div class="form-group col-md-6">
							<label for="contests">{#contestNewFormContestToEdit#}</label>
							<select class='contests form-control' name='contests' id='contest_alias'>
								<option value=""></option>				
							</select>
						</div>
					</div>
				{/if}
				
				<div class="row">
					<div class="form-group col-md-6">
						<label for="title">{#wordsTitle#}</label>
						<input id='title' name='title' value='' type='text' size='30' class="form-control">
					</div>
					
					<div class="form-group col-md-6">
						<label for="alias">Título corto (alias)</label>
						<input id='alias' name='alias' value='' type='text' class="form-control" {IF $IS_UPDATE eq 1} disabled="true" {/if}>
						<p class="help-block">El título corto se usa para construir la URL del concurso (ejemplos: ANPA2010, CONACUP2012, OMI2013, etc..). {#wordsNo#} puede contener espacios.</p>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label for="start_time">{#contestNewFormStartDate#}</label>
						<input id='start_time' name='start_time' value='' class="form-control" type='text' size ='16'>
						<p class="help-block">La fecha (en hora local) en la que inicia el concurso</p>
					</div>
					
					<div class="form-group col-md-6">
						<label for="finish_time">{#contestNewFormEndDate#}</label>
						<input id='finish_time' name='finish_time' value='' class="form-control" type='text' size='16'>
						<p class="help-block">La hora (en hora local) en la que termina el concurso.
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label for="description">Descripci&oacute;n del concurso</label>
						<textarea id='description' name='description' cols="30" rows="10" class="form-control"></textarea>
					</div>
					
					<div class="form-group col-md-6">
						<label for="window_length_enabled">Inicios Diferentes</label>
						<div class="checkbox">
							<label>
								<input type='checkbox' id='window_length_enabled' name='window_length_enabled'>	Habilitar
							</label>
						</div>
						<input id='window_length' name='window_length' value='' type='text' disabled="true" size='3' class="form-control">
						<p class="help-block">Si está activo, indica el tiempo en minutos que tiene el {#wordsUser#} para concursar y env&iacute;ar soluciones a partir de que entra al concurso en la arena (estilo USACO/Preselectivo IOI).
						Si Inicios Diferentes está desactivado, entonces el concursante tendrá todo el tiempo entre la {#contestNewFormStartDate#} y la {#contestNewFormEndDate#} para concursar.</p>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label for="scoreboard">¿Cuánto tiempo se mostrará el Scoreboard? (%)</label>
						<input id='scoreboard' name='scoreboard' value='100' type='text' size='3' class="form-control">
						<p class="help-block">Entero del 0 al 100, indicando el porcentaje de tiempo que el scoreboard ser&aacute; visible.</p>
					</div>
					
					<div class="form-group col-md-6">
						<label for="submissions_gap">Separación de envios</label>
						<input id='submissions_gap' name='submissions_gap' value='1' type='text' size='2' class="form-control">
						<p class="help-block">Tiempo m&iacute;nimo en minutos que debe de esperar un concursante despues de realizar un env&iacute;o para hacer otro.</p>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label for="penalty_time_start">{#contestNewFormPenaltyType#}</label>
						<select name='penalty_time_start' id='penalty_time_start' class="form-control">
							<option value='none'>{#contestNewFormNoPenalty#}</option>
							<option value='problem'>{#contestNewFormByProblem#}</option>
							<option value='contest'>{#contestNewFormByContests#}</option>
						</select>
						<p class="help-block">Indica el momento cuando se inicia a contar el tiempo: cuando inicia el concurso o cuando se abre el problema.</p>
					</div>
					
					<div class="form-group col-md-6">
						<label for="penalty">{#wordsPenalty#}</label>
						<input id='penalty' name='penalty' value='0' type='text' size='2' class="form-control">
						<p class="help-block">Entero indicando el n&uacute;mero de minutos con que se penaliza por enviar una respuesta incorrecta.</p>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label for="feedback">{#wordsFeedback#}</label>
						<select name='feedback' id='feedback' class="form-control">
							<option value='yes'>Sí</option>
							<option value='no'>{#wordsNo#}</option>
							<option value='partial'>{#wordsPartial#}</option>
						</select>
						<p class="help-block">Si al {#wordsUser#} se le entrega retroalimentación inmediata sobre su problema</p>
					</div>
					
					<div class="form-group col-md-6">
						<label for="points_decay_factor">Factor de Decrecimiento de Puntaje</label>
						<input id='points_decay_factor' name='points_decay_factor' value='0.0' type='text' size='4' class="form-control">
						<p class="help-block">Un número entre 0 y 1 inclusive. Si este número es distinto de cero, el puntaje que se obtiene al resolver correctamente un problema decae conforme pasa el tiempo. El valor del puntaje estará dado por (1 - points_decay_factor) + points_decay_factor * TT^2 / (10 * PT^2 + TT^2), donde PT es el penalty en minutos del envío y TT el tiempo total del concurso, en minutos.</p>
					</div>
				</div>
				
				<div class="row">
					<div class="form-group col-md-6">
						<label for="show_scoreboard_after">Scoreboard al finalizar el concurso</label>
						<select id='show_scoreboard_after' name='show_scoreboard_after' class="form-control">
							<option value='1'>Sí</option>
							<option value='0'>{#wordsNo#}</option>
						</select>
						<p class="help-block">Mostrar automáticamente el scoreboard completo al finalizar el concurso.</p>
					</div>
					
					<div class="form-group col-md-6">
						<label for="public">Público</label>
						<select name='public' id='public' class="form-control">
							<option value='1'>Sí</option>
							<option value='0'>{#wordsNo#}</option>
						</select>
						<p class="help-block">Mostrar el concurso en el listado público.</p>
					</div>
				</div>
				
				<div class="form-group">
				{if $IS_UPDATE eq 1}
					<button type='submit' class="btn btn-primary">{#contestNewFormUpdateContest#}</button>
				{else}
					<button type='submit' class="btn btn-primary">{#contestNewFormScheduleContest#}</button>
				{/if}
				</div>
		</form>
	</div>
</div>
<script>		
	
	$("#start_time, #finish_time").datetimepicker({
		weekStart: 1,
		format: "mm/dd/yyyy hh:ii",
		startDate: Date.create(Date.now()),
	});
	
	{IF $IS_UPDATE neq 1}
		// Defaults for start_time and end_time	
		var defaultDate = Date.create(Date.now());
		defaultDate.set({ seconds: 0 });
		$('#start_time').val(dateToString(defaultDate));	
		defaultDate.setHours(defaultDate.getHours() + 5);
		$('#finish_time').val(dateToString(defaultDate));
	{/IF}
	
	$("#window_length_enabled").change(function () {
		if ($(this).is(":checked")) {
			$('#window_length').removeAttr('disabled');
		} else {
			$('#window_length').attr('disabled','disabled');
		}
	});
	
	// Defaults for OMI
	$('#omi').click(function() {
		$(".new_contest_form #title").val('**Estilo OMI aplicado. Pon tu título aquí**');
		$('#window_length_enabled').removeAttr('checked');
		$('#window_length').attr('disabled','disabled');
		$('#window_length').val('');
		
		$(".new_contest_form #public").val('1');
		$(".new_contest_form #scoreboard").val('0');
		$(".new_contest_form #points_decay_factor").val('0');		
		$(".new_contest_form #submissions_gap").val('1');
		$(".new_contest_form #feedback").val('yes');
		$(".new_contest_form #penalty").val('0');
		$(".new_contest_form #penalty_time_start").val('none');
		$(".new_contest_form #show_scoreboard_after").val('1');		
	});
	
	// Defaults for preselectivos IOI
	$('#preioi').click(function() {
		$(".new_contest_form #title").val('**Estilo Preselectivo aplicado. Pon tu título aquí**');
		$('#window_length_enabled').attr('checked', 'checked');
		$('#window_length').removeAttr('disabled');
		$('#window_length').val('180');
		
		$(".new_contest_form #public").val('1');
		$(".new_contest_form #scoreboard").val('0');
		$(".new_contest_form #points_decay_factor").val('0');		
		$(".new_contest_form #submissions_gap").val('0');
		$(".new_contest_form #feedback").val('yes');
		$(".new_contest_form #penalty").val('0');
		$(".new_contest_form #penalty_time_start").val('none');
		$(".new_contest_form #show_scoreboard_after").val('1');		
	});
	
	// Defaults for CONACUP
	$('#conacup').click(function() {
		$(".new_contest_form #title").val('**Estilo CONCACUP aplicado. Tu título aquí**');
		$('#window_length_enabled').removeAttr('checked');
		$('#window_length').attr('disabled','disabled');
		$('#window_length').val('');
		
		$(".new_contest_form #public").val('1');
		$(".new_contest_form #scoreboard").val('75');
		$(".new_contest_form #points_decay_factor").val('0');		
		$(".new_contest_form #submissions_gap").val('1');
		$(".new_contest_form #feedback").val('yes');
		$(".new_contest_form #penalty").val('20');
		$(".new_contest_form #penalty_time_start").val('contest');
		$(".new_contest_form #show_scoreboard_after").val('1');		
	});
</script>
