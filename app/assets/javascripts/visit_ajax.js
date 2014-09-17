$(document).ready(function() {

  var refreshCoupons = function() {
    $.get('visits/coupons_served_up.html', function(data) {
      var couponElement = $("#coupons");
      $('#coupons').html(data);
    })
  };

  var checkForNewActivity = function(visitCount) {
    $.get('visits/activity.json', function(data) {
      if (data.visit_count > visitCount) {
        refreshCoupons();
      }
      setTimeout(function() {checkForNewActivity(data.visit_count)}, 2000);
    });
  }

  if ($("#coupons").length > 0) {
    checkForNewActivity(0);
  }
});

