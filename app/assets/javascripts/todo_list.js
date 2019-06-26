$(function() {

    // マンダラチャートからTODOリストを追加する処理
    $('#btnAdd_chart').on('click', function () {
        $('#add_task_messages').show();
        $(document).on('click', '.task_select', function() {
            $.ajax({
                url: "/tasks",
                type: "POST",
                dataType: 'html', // 受信時のデータ形式
                contentType: 'application/json', //送信時のデータ形式
                data: JSON.stringify({
                    task: {
                        user_id: $(this).find('#user_id').val(),
                        element_id: $(this).find('#element_id').val(),
                        content: $(this).find('.text').text(),
                        limit: new Date()
                    },
                    ajax: true
                })
            })
            .done(function(data) {
                $('#todo_content').html(data);
            })
            .fail(function(data) {
                alert('通信に失敗しました')
            });
        });
    });

});

// エラー表示を消す(Ajaxで動的に表現する為,documentに対してイベントハンドラを登録)
$(document).on('click', '#alert_close', function() {
    $('#divAlert').hide();
});
$(document).on('click', '#message_close', function() {
    $('#add_task_messages').hide();
    $(document).off('click', '.task_select');
});

// 警告部の初期化
function clearDivAlert(){
    $('#divAlert').css('display', 'none');
    $('#inputAlert').text('');
}