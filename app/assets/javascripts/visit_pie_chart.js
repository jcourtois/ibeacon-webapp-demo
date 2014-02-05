$(document).ready(function() {
    if ($("#visitsPieChart").length == 1) {
        var ctx = document.getElementById("visitsPieChart").getContext("2d");

        var pie_data = [
            {
                value: 30,
                color:"#F38630"
            },
            {
                value : 50,
                color : "#E0E4CC"
            },
            {
                value : 100,
                color : "#69D2E7"
            }
        ]
        var pie_data = $('#visitsPieChart').data('visits')
        var pie_options = null;
        var myNewChart = new Chart(ctx).Doughnut(pie_data, pie_options);
    }
});