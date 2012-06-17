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
    content.animate({opacity:0}, 500);
    $.ajax({
      type: "GET",
      url: that.attr("href"),
      success: function(data){
        $('.content').html(data).animate({opacity:100}, 500);
        var user_table_td = $(".leaderboard tr#user_" + current_user_id + "_points td:first");
        if (user_table_td.length > 0){
          user_table_td.append("<i class='icon-hand-right'></i>");
        }
      }
    });
    event.preventDefault();
    return false;
  });

  if($("#today").length > 0){
    $('html, body').animate({ scrollTop: $('#today').offset().top }, 'slow');
  }

});