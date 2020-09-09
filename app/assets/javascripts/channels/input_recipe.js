$(function(){
    $("form").submit(function(){
        //エラーの初期化
        $("p.error").remove();
        $("dl dd").removeClass("error");
        $(":text,textarea").filter(".validate").each(function(){
            var post_radio = $('input[name="optionsRadios"]:checked').val();
            //必須項目のチェック
            $(this).filter(".required_dish_name").each(function(){
                if($(this).val()==""){
                    $(this).parent().prepend("<p class='error'>※住所を入力してください</p>")
                }
            })
            $(this).filter(".required_method").each(function(){
                if($(this).val()==""){
                    $(this).parent().prepend("<p class='error'>※宛名を入力してください</p>")
                }
            })
        })
        //エラーの際の処理
        if($("p.error").size() > 0){
                $('html,body').animate({ scrollTop: $("p.error:first").offset().top-40 }, 'slow');
                $("p.error").parent().addClass("error");
                return false;
        }
    })
})