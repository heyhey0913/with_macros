$(function() {
  $('input').change(function() {
    var protein_content = $('#ingredient_protein_content').val();
    var fat_content = $('#ingredient_fat_content').val();
    var carbohydrate_content = $('#ingredient_carbohydrate_content').val();

    var protein_calorie = 4*parseFloat(protein_content);
    var fat_calorie = 9*parseFloat(fat_content);
    var carbohydrate_calorie = 4*parseFloat(carbohydrate_content);
    var calculated_total_calorie = protein_calorie + fat_calorie + carbohydrate_calorie;

    if(calculated_total_calorie > 0){
      $('#calculated_total_calorie').text(Math.round(calculated_total_calorie));
    } else {
      $('#calculated_total_calorie').text("必須項目を正しく入力してください");
    }
  });
});