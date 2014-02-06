$(document).ready(function() {
    var generateChart = function(elementId) {
        if ($("#" + elementId).length == 1) {
            var ctx = document.getElementById(elementId).getContext("2d");
            var data = $('#' + elementId).data('visits')
            var options = {
                animation: false
            };
            var myNewChart = new Chart(ctx).Doughnut(data, options);
        }
    };

    generateChart('smooth-doughnut-chart');
    generateChart('doughnut-chart');
});
