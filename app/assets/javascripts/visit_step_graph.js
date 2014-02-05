$( document ).ready(function() {
    if ($("#visit_step_graph").length == 1) {
        var d1 = [
            [1383582043000, 1],
            [1383583043000, 1],
            [1383584043000, 2],
            [1383585043000, 2],
            [1383586043000, 2],
            [1383592043000, 5],
            [1383602043000, 5],
            [1383603043000, 7],
            [1383604043000, 7],
            [1383607043000, 3],
            [1383610043000, 3],
            [1383618043000, 6],
            [1383622043000, 6],
            [1383622043000, 5],
            [1383623043000, 5]
        ]

        var flot_data = [
    //        {
    //            data: d1,
    //            label: 'Epsilon stepwise steps',
    //            lines: { show: true },
    //            points: { show: true }
    //        },
            {
                data: d1,
                label: 'Stepwise',
                lines: { show: true, steps: true },
                points: { show: true }
            }
        ]

        var flot_options = {
            grid: {
                clickable: true,
                hoverable: true
            },
            xaxis: {
                mode: "time",
                timeformat: "%I:%M:%S %P",
                minTickSize: [2, "hour"]
            },
            yaxis: {
                ticks: [
                    [0, ''],
                    [1, 'Cheese'],
                    [2, 'Wine Cellar'],
                    [3, 'Meat'],
                    [4, 'Dairy'],
                    [5, 'Frozen'],
                    [6, 'Packaged'],
                    [7, 'Books'],
                    [8, 'Pet Food'],
                    [9, '']
                ]
            }
        }


        var flot_plot = $.plot("#visit_step_graph", flot_data, flot_options);

        $("<div id='tooltip'></div>").css({
            position: "absolute",
            display: "none",
            border: "1px solid #fdd",
            padding: "2px",
            "background-color": "#fee",
            opacity: 0.80
        }).appendTo("body");

        $("#visit_step_graph").bind("plothover", function (event, pos, item) {

                if (item) {
                    var x = item.datapoint[0],
                        y = item.datapoint[1];

    //                $("#tooltip").html(item.series.label + ": " + x + " is " + y)
                    $("#tooltip").html(new Date(x).toLocaleTimeString())
                        .css({top: item.pageY+5, left: item.pageX+5})
                        .fadeIn(200);
                }
        });

        $("#visit_step_graph").bind("plotclick", function (event, pos, item) {
            if (item) {
                flot_plot.highlight(item.series, item.datapoint);
            }
        });

        $("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
    }
});
