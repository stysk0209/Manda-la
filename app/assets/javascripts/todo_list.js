// TODOリストの処理
$(function() {

});

// 追加ボタンを押した時の処理
$("#btnAdd").on("click", function() {



    // // 入力チェック(空白を除き、文字数が0か確認)
    // if ($('#inputTask').val().trim().length == 0){
    //      $('#divAlert').css('display', 'block'); //警告部の表示
    //      $('#inputAlert').text('タスク内容を入力してください');
    //     return;
    // };

    // if ($('#inputLimit').val().trim().length == 0){
    //      $('#divAlert').css('display', 'block');　//警告部の表示
    //      $('#inputAlert').text('期限を入力してください');
    //     return;
    // };


});

// マンダラチャートからTODOリストを追加する処理
$("#btnAdd_chart").on('click', function() {

    $('').append('<div id="modal-overlay"></div>');

});

// エラー表示を消す(Ajaxで動的に表現する為,documentに対してイベントハンドラを登録)
$(document).on('click', '#alert_close', function() {
    $('#divAlert').css('display', 'none');
});

// 警告部の初期化
function clearDivAlert(){
    $('#divAlert').css('display', 'none');
    $('#inputAlert').text('');
}