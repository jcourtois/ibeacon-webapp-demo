$(document).ready(function() {

  var refreshCoupons = function() {
    $.get('visits/coupons_served_up.html', function(data) {
      var couponElement = $("#coupons");
      $('#coupons').html(data);
    });
  };

  var refreshPieChart = function() {
    $.get('visits/pie_chart_data.json', function(data) {
      var options = { animation: false };
      pieChart.Doughnut(data, options);
    });
  };


  var checkForNewActivity = function(visitCount) {
    $.get('visits/activity.json', function(data) {
      if (data.visit_count > visitCount) {
        refreshCoupons();
        refreshPieChart();
      }
      setTimeout(function() {checkForNewActivity(data.visit_count)}, 2000);
    });
  }

  if ($("#coupons").length > 0) {
    var pieChartContext = document.getElementById('smooth-doughnut-chart').getContext("2d");
    var pieChart = new Chart(pieChartContext);

    checkForNewActivity(0);
  }
});
