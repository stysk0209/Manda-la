
$(function() {

	var ctx = $("#Radar_chart");
	var radarChart = new Chart(ctx, {
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
			scale: {
				ticks: {
					beginAtZero: true,
					max: 50,
					min: 0
				}
			},
			plugins: {
				colorschemes: {
					scheme: 'brewer.RdYlGn8'
				}
			}
		}
	});

	var ctx = $("#Task_complete_graph");
	var barChart = new Chart(ctx, {
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
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero: true,
						max: 10,
						min: 0
					}
				}]
			},
			plugins: {
				colorschemes: {
					scheme: 'brewer.RdYlGn8'
				}
			}
		}
	});

});