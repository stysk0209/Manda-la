$(function() {

	if ( gon.step == 1 ) {
		$('#element1,#element2,#element3,#element4,#element6,#element7,#element8,#element9').removeClass('modal_open');
		$('#element1,#element2,#element3,#element4,#element6,#element7,#element8,#element9').parent().removeClass('squares-gray');
		$('#element1,#element2,#element3,#element4,#element6,#element7,#element8,#element9').parent().addClass('squares-disabled');
		$('#element1,#element2,#element3,#element4,#element6,#element7,#element8,#element9').find('.element_val,.element_num').prop('disabled', true);
	} else if ( gon.step == 3 || gon.step == "edit" ) {
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').removeClass('modal-open');
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').addClass('element_link');
	} else if (gon.step == "element_select") {
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').removeClass('el_select');
		$('#element1,#element2,#element3,#element4,#element5,#element6,#element7,#element8').addClass('task_select');
		$('#element_center').addClass('el_select_center');
	} else { // (gon.step == "element_overlooking")
	}


	// モーダルを開く
	$('.modal_open').on('click', function() {
		let title = $(this).find('.element_title').text();
		$('#header-text').text(title);
		let modal = $(this).attr('target');
		let element = $(this).find('.element_val'); //form(hidden_field)を取得
		let body_text = $(this).find('.text'); //クリックした要素のテキストを取得
		$('#input').val($(body_text).text())
		$(this).blur(); //多重起動防止のため、フォーカスを外す
		ModalOpen(modal);

		// モーダルを閉じる
		$('#modal-overlay,#modal_close').on('click', function() {
			$(modal + ', #modal-overlay').fadeOut('slow', function() {
				$('#modal-overlay').remove();
			});
		});
		// 入力内容を保存して閉じる
		$('#done').off('click'); //処理がループしないようにイベントを削除！
		$('#done').on('click', function() {
			let val = $("#input").val();
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
		let id = $(this).find('.element_num').val();
		let url = $(location).attr('pathname');
	window.location.href = url + "?element_edit=" + id
	});

	// Userマイページ マンダラチャート用(各要素の詳細へ遷移)
	$('.el_select').off('click');
	$('.el_select').on('click', function() {
		let id = $(this).attr('id').replace('element', "");
		let url = $(location).attr('href');
		window.location.href = url + "?element_select=" + id;
	});
	// Userマイページ マンダラチャート用(中心の要素をクリックで戻る)
	$('.el_select_center').off('click');
	$('.el_select_center').on('click', function() {
		window.location.href = $(location).attr('pathname');
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
	let w = $(window).width();
	let h = $(window).height();
	// モーダルの高さと幅を取得して、変数に格納
	let cw = $(modal).outerWidth();
	let ch = $(modal).outerHeight();
	// コンテンツを真ん中に配置するために必要な余白を計算
	let pxleft = ((w - cw)/2);
	let pxtop = ((h - ch)/2);
	// モーダルのcssに余白の設定
	$(modal).css({'left': pxleft + 'px'});
	$(modal).css({'top': pxtop + 'px'});
}