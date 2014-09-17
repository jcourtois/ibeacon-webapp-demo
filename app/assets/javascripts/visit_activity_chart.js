$(document).ready(function() {
  var data = {
    labels: ["Dairy", "Soup", "Salad Dressing", "Crackers"],
    datasets: [
        {
            label: "Coupons Delivered",
            fillColor: "rgba(220,220,220,0.5)",
            strokeColor: "rgba(220,220,220,0.8)",
            highlightFill: "rgba(220,220,220,0.75)",
            highlightStroke: "rgba(220,220,220,1)",
            data: [0, 1, 1, 1]
        },
        {
            label: "Coupons Clicked",
            fillColor: "rgba(151,187,205,0.5)",
            strokeColor: "rgba(151,187,205,0.8)",
            highlightFill: "rgba(151,187,205,0.75)",
            highlightStroke: "rgba(151,187,205,1)",
            data: [0, 1, 0, 1]
        }
    ]
};
    var generateChart = function(elementId) {
        if ($("#" + elementId).length == 1) {
            var ctx = document.getElementById(elementId).getContext("2d");
            //var data = $('#' + elementId).data('visits')
            var options = {
                animation: false,
                width: '100%',
                barValueSpacing: 30,
                scaleShowGridLines: false,
                scaleShowLabels: false,
            };
            var activityChart = new Chart(ctx).StackedBar(data, options);
            $("#" + elementId).parent().append($('.activity-chart-legend'));
        }
    };

    generateChart('visit-activity-chart');
});
