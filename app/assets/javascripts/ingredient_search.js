$(function() {
  $("#ingredient_form").keyup(function() {
    return $("#ingredient_form").find("input[type='submit']").click();
  });
  $("#ingredient_form").change(function() {
    return $("#ingredient_form").find("input[type='submit']").click();
  });
  return $('#ingredient_form').on('ajax:success', function(event, results) {
    var $select, $trs;
    $select = $("#ingredient_check");
    $trs = $select.find("tr");
    return $trs.each(function() {
      var value;
      value = parseInt($(this).find("td").first().text());
      if (indexOf.call(results, value) >= 0) {
        return $(this).show();
      } else {
        return $(this).hide();
      }
    });
  });
});