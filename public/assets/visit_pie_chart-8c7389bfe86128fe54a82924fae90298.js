$(document).ready(function() {
    var ctx = document.getElementById("visitsPieChart").getContext("2d");

    var data = [
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
    var data = $('#visitsPieChart').data('visits')
    var options = null;
    var myNewChart = new Chart(ctx).Pie(data, options);
});
