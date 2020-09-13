
$(function(){
    // inputのidから情報の取得
    $('.item_image').on('change', function (e) {
// ここから既存の画像のurlの取得
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".dish_image").attr('src', e.target.result);
    }
// ここまで
    reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
});
});

$(function(){
    // フォームにtype="hidden"のinput要素を追加
    $('form').append('<input name="key" type="hidden" value="" />');
    // ボタンクリック時、type="hidden"のinput要素に自分の値を設定
    $('input').click(function(){
        $('input[name=key]').val($(this).val());
    });
    $("form").submit(function(){
        var submit_value = $('#next').val();
        if($('input[name=key]').val() == '内容確認へ進む'){
            //エラーの初期化
            $("p.error").remove();
            $("dl dd").removeClass("error");
            $(":text,textarea").filter(".validate").each(function(){
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
            if($("p.error")[0]){
                $('html,body').animate({ scrollTop: $("p.error:first").offset().top-40 }, 'slow');
                $("p.error").parent().addClass("error");
                return false;
            }
        }
    })
})