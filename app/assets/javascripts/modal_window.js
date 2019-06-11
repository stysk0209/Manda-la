$(function() {
	if (gon.registfail == "false") {
		var modal = '#modal1'
		ModalOpen(modal);
		gon.clear
	}
	else if (gon.log_in_fail == "false") {
		var modal = '#modal2'
		ModalOpen(modal);
		gon.clear
	}

	$('.modal-open').on('click', function() {
		var modal = $(this).attr('target');
		$(this).blur(); //多重起動防止のため、フォーカスを外す
		ModalOpen(modal);
	});

});


function ModalOpen(modal) {
		if ($("#modal-overlay")[0]) return false; //2回目以降モーダルを表示しない
		$('body').append('<div id="modal-overlay"></div>');
		$('#modal-overlay').fadeIn('slow');
		// モーダルをセンタリング
		centeringModelSyncer(modal);
		// モーダルをフェードイン
		$(modal).fadeIn('slow');
		// モーダルを閉じる
		$('#modal-overlay,#modal-close').on('click', function() {
			$(modal + ', #modal-overlay').fadeOut('slow', function() {
				$('#modal-overlay').remove();
			sessionStorage.removeItem('regist_fail');
			});
		});
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