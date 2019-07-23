
$(function() {

	if (typeof gon.scores_this_week !== "undefined") {

		var ctx1 = $("#Radarchart_weekly");
		var radarChart = new Chart(ctx1, {
			type: 'radar',
			data: {
				labels: gon.element,
				datasets: [{
				label: "今週",
				data : gon.scores_this_week
				},
				{
				label: "先週",
				data : gon.scores_last_week
				}]
			},
			options: {
				responsive: true,
				plugins: {
					colorschemes: {
						scheme: 'brewer.RdYlGn8'
					}
				},
				scale: {
					ticks: {
						min: 0
					}
				}
			}
		});

		var ctx2 = $("#Achieved_weekly");
		var barChart = new Chart(ctx2, {
			type: 'bar',
			data: {
				labels: ['日', '月', '火', '水', '木', '金', '土'],
				datasets: [{
					label: "今週",
					data : gon.task_comp_this_week
				},
				{
					label: "先週",
					data : gon.task_comp_last_week
				}]
			},
			options: {
				responsive: true,
				plugins: {
					colorschemes: {
						scheme: 'brewer.RdYlGn8'
					}
				}
			}
		});

	} else {

		var ctx3 = $("#Radarchart_comp");
		var radarChart = new Chart(ctx3, {
			type: 'radar',
			data: {
				labels: gon.element,
				datasets: [{
				label: "タスク達成数 総計",
				data : gon.score_all
				}]
			},
			options: {
				responsive: true,
				plugins: {
					colorschemes: {
						scheme: 'brewer.RdYlGn8'
					}
				},
				scale: {
					ticks: {
						min: 0
					}
				}
			}
		});


		var ctx4 = $("#Achieved_comp");
		var date = new Date();
		var month = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
		var radarChart = new Chart(ctx4, {
			type: 'line',
			data: {
				labels: [month[MonthSelect(date.getMonth() - 5)], month[MonthSelect(date.getMonth() - 4)], month[MonthSelect(date.getMonth() - 3)],
						month[MonthSelect(date.getMonth() - 2)], month[MonthSelect(date.getMonth() - 1)], month[MonthSelect(date.getMonth())]],
				datasets: [{
				label: "タスク達成数 総計",
				data : gon.achieved_comp
				}]
			},
			options: {
				responsive: true,
				plugins: {
					colorschemes: {
						scheme: 'brewer.RdYlGn8'
					}
				}
			}
		});
	}

});


$('#button_comp').on('click', function() {
	$('#graph_weekly').hide();
	$('#graph_comp').show();
	$('#button_weekly').hide();
	$('#button_comp').show();
});
$('#button_weekly').on('click', function() {
	$('#graph_comp').hide();
	$('#graph_weekly').show();
	$('#button_comp').hide();
	$('#button_weekly').show();
});


// 数値がマイナスの場合は、12を足して返す
function MonthSelect(number) {
	if (number < 0) {
		return number + 12
	}
	return number
}