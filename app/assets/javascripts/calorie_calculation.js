

$(function() {
  $('input').change(function() {
    var current_weight = $('#user_current_weight').val();
    var current_body_fat = $('#user_current_body_fat').val();
    var active_factor = $('#user_active_factor').val();
    var weekly_target_weight = $('#user_weekly_target_weight').val();

    var bmr = 370 + 21.6 * parseFloat(current_weight) * (1 - parseFloat(current_body_fat)/100);
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
    var current_weight = $('#user_current_weight').val();
    var current_body_fat = $('#user_current_body_fat').val();
    var active_factor = $('#user_active_factor').val();
    var weekly_target_weight = $('#user_weekly_target_weight').val();

    var bmr = 370 + 21.6 * parseFloat(current_weight) * (1 - parseFloat(current_body_fat)/100);
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