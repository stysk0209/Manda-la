$(function() {

	if ( gon.step == 1 ) {
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').removeClass('modal_open');
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').parent().removeClass('squares-gray');
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').parent().addClass('squares-disabled');
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').find('.element_val,.element_num').prop('disabled', true);
	} else if ( gon.step == 3 || gon.step == "edit" ) {
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').removeClass('modal-open');
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').addClass('element_link');
	} else if (gon.step == "element_select") {
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').removeClass('el_select');
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').addClass('task_select');
		$('#element_center').addClass('el_select_center');
	} // (gon.step == "element_overlooking")


	// モーダルを開く
	$('.modal_open').on('click', function() {
		var title = $(this).find('.element_title').text();
		$('#header-text').text(title);
		var modal = $(this).attr('target');
		var element = $(this).find('.element_val'); //form(hidden_field)を取得
		var body_text = $(this).find('.text'); //クリックした要素のテキストを取得
		$('#input').val($(body_text).text())
		$(this).blur(); //多重起動防止のため、フォーカスを外す
		ModalOpen(modal);
		$('#input').focus();

		// モーダルを閉じる
		$('#modal-overlay,#modal_close').on('click', function() {
			$(modal + ', #modal-overlay').fadeOut('slow', function() {
				$('#modal-overlay').remove();
			});
		});
		// 入力内容を保存して閉じる
		$('#done').off('click'); //処理がループしないようにイベントを削除！
		$('#done').on('click', function() {
			var val = $("#input").val();
			$(body_text).text(val);
			$(element).val(val);

			$(modal + ', #modal-overlay').fadeOut('slow', function() {
				$('#modal-overlay').remove();
			});
		});
	});

	// マンダラチャート作成画面用
	$('.element_link').off('click');
	$('.element_link').on('click', function() {
		var id = $(this).find('.element_num').val();
		var url = $(location).attr('pathname');
		window.location.href = url + "?element_edit=" + id
	});

	//STEP3で、入力済みの要素にホバーしたら、入力OKを表示する
	$('.squares').hover(function() {
		element_text = $(this).find('.text').text();
		if ($(this).find('#activitiy_comp').val() == "true" ) {
			$(this).find('.text').text('入力OK');
			$('head').append('<style>.squares:hover { background-color: rgba(100, 204, 204, 0.75); color: #fff; }</style>');
		}
	}, function() {
		$(this).find('.text').text(element_text);
		$('head').append('<style>.squares:hover { background-color: rgba(204, 204, 204, 0.75); }</style>');
	});

	// Userマイページ マンダラチャート用(各要素の詳細へ遷移)
	$('.el_select').off('click');
	$(document).on('click', '.el_select', function() {
		var id = $(this).attr('id').replace('element', "");
		$.ajax({
				url: $(location).attr('pathname'),
				scriptCharset: 'UTF-8',
				type: "GET",
				dataType: 'html', // 受信時のデータ形式
				contentType: 'application/json', //送信時のデータ形式
				data: {
					ajax: true,
					element_select: id
				}
		})
		.done(function(data) {
			$('#mandala_field').html(data);
			$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').removeClass('el_select');
			$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').addClass('task_select');
			$('#element_center').addClass('el_select_center');
		})
		.fail(function(data) {
			alert('通信に失敗しました')
		});
	});
	// Userマイページ マンダラチャート用(中心の要素をクリックで戻る)
	$('.el_select_center').off('click');
	$(document).on('click', '.el_select_center', function() {
		$.ajax({
				url: $(location).attr('pathname'),
				scriptCharset: 'UTF-8',
				type: "GET",
				dataType: 'html', // 受信時のデータ形式
				contentType: 'application/json', //送信時のデータ形式
				data: {
					ajax: true
				}
		})
		.done(function(data) {
			$('#mandala_field').html(data);
			$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').removeClass('task_select');
			$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').addClass('el_select');
			$('#element_center').removeClass('el_select_center');
		})
		.fail(function(data) {
			alert('通信に失敗しました')
		});
	});
});


function ModalOpen(modal) {
		if ($("#modal-overlay")[0]) return false; //2回目以降モーダルを表示しない
		$('body').append('<div id="modal-overlay"></div>');
		$('#modal-overlay').fadeIn('slow');
		// モーダルをセンタリング
		centeringModelSyncer(modal);
		// モーダル非表示を解除
		$(modal).css({'display': ''});
		// モーダルをフェードイン
		$(modal).fadeIn('slow');
}


function centeringModelSyncer(modal) {
	// 画面の高さと幅を取得して、変数に格納
	var w = $(window).width();
	var h = $(window).height();
	// モーダルの高さと幅を取得して、変数に格納
	var cw = $(modal).outerWidth();
	var ch = $(modal).outerHeight();
	// コンテンツを真ん中に配置するために必要な余白を計算
	var pxleft = ((w - cw)/2);
	var pxtop = ((h - ch)/2);
	// モーダルのcssに余白の設定
	$(modal).css({'left': pxleft + 'px'});
	$(modal).css({'top': pxtop + 'px'});
}