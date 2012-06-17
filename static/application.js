$(function() {

  $(".submit_prediction").on("click", function(event) {
    var that = $(this);
    that.attr("disabled", "disabled");
    that.attr("value", "Submitting...");
    var form = that.parents("form");
    var selected_option = form.find("input:checked")
    if(selected_option.length == 1){
      var data_string = 'prediction='+selected_option.val();
      $.ajax({
        type: "POST",
        url: form.attr("action"),
        data: data_string,
        success: function(data) {
          euro_data = data;
          that.removeAttr("disabled");
          if(data['result'] != undefined){
            var prediction_div = form.parents(".prediction");
            prediction_div.find("span.prediction_message").html(data['result']);
            prediction_div.find("a.prediction_link").html("Change");
            prediction_div.find(".modal").modal("hide");
          }else {
            form.find(".alert").html(data['error']).show();
          }
        }
      });
    }else {
      form.find(".alert").html("You GOTs to select one of the results").show();
    }
    event.preventDefault();
    return false;
  });


  $("a[data-remote]").on("click", function(event){
    var that = $(this);
    var content = $('.content');
    // content.animate({opacity:0}, 500);
    $("#dummy_modal .modal").modal("show");
    $.ajax({
      type: "GET",
      url: that.attr("href"),
      success: function(data){
        $('.content').html(data);
        $("#dummy_modal .modal").modal("hide");
        highlight_current_user_row();
      }
    });
    event.preventDefault();
    return false;
  });

  if($("#today").length > 0){
    $('html, body').animate({ scrollTop: $('#today').offset().top }, 'slow');
  }


  highlight_current_user_row = function(){
    var user_table_td = $(".leaderboard tr#user_" + current_user_id + "_points td:first");
    if (user_table_td.length > 0){
      user_table_td.append("<i class='icon-hand-right'></i>");
    }
  }

  start_spinner = function(){
    var opts = {
      lines: 13, // The number of lines to draw
      length: 30, // The length of each line
      width: 12, // The line thickness
      radius: 23, // The radius of the inner circle
      rotate: 28, // The rotation offset
      color: '#fff', // #rgb or #rrggbb
      speed: 1.3, // Rounds per second
      trail: 42, // Afterglow percentage
      shadow: true, // Whether to render a shadow
      hwaccel: false, // Whether to use hardware acceleration
      className: 'spinner', // The CSS class to assign to the spinner
      zIndex: 2e9, // The z-index (defaults to 2000000000)
      top: 'auto', // Top position relative to parent in px
      left: 'auto' // Left position relative to parent in px
    };
    var target = document.getElementById('spinner');
    var spinner = new Spinner(opts).spin(target);
  }

  start_spinner();
  highlight_current_user_row();

});