

$(function() {
  $('input').change(function() {
    var initial_weight = $('#project_initial_weight').val();
    var body_fat = $('#project_body_fat').val();
    var active_factor = $('#project_active_factor').val();
    var weekly_target_weight = $('#project_weekly_target_weight').val();

    var bmr = 370 + 21.6 * parseFloat(initial_weight) * (1 - parseFloat(body_fat)/100);
    var maintenance_calorie = bmr * parseFloat(active_factor) ;
    var day_limit_calorie = maintenance_calorie - 1000 * parseFloat(weekly_target_weight) ;

    if(day_limit_calorie > 0){
    	$('#day_limit_calorie').text(Math.round(bmr));
    	$('#day_limit_calorie').text(Math.round(maintenance_calorie));
    	$('#day_limit_calorie').text(Math.round(day_limit_calorie));
    } else {
    	$('#day_limit_calorie').text("必須項目を正しく入力してください")
	}
  });
});

$(function() {
  $('select').change(function() {
    var initial_weight = $('#project_initial_weight').val();
    var body_fat = $('#project_body_fat').val();
    var active_factor = $('#project_active_factor').val();
    var weekly_target_weight = $('#project_weekly_target_weight').val();

    var bmr = 370 + 21.6 * parseFloat(initial_weight) * (1 - parseFloat(body_fat)/100);
    var maintenance_calorie = bmr * parseFloat(active_factor) ;
    var day_limit_calorie = maintenance_calorie - 1000 * parseFloat(weekly_target_weight) ;

    if(day_limit_calorie > 0){
        $('#day_limit_calorie').text(Math.round(bmr));
        $('#day_limit_calorie').text(Math.round(maintenance_calorie));
        $('#day_limit_calorie').text(Math.round(day_limit_calorie));
    } else {
        $('#day_limit_calorie').text("必須項目を正しく入力してください")
    }
  });
});