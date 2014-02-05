$(document).ready(function() {
    if ($("#visitsPieChart").length == 1) {
    	var ctx = document.getElementById("visitsPieChart").getContext("2d");
    	var data = $('#visitsPieChart').data('visits')
    	var options = null;
    	var myNewChart = new Chart(ctx).Doughnut(data, options);
    }
});
