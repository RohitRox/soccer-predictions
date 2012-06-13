$(function() {  
  $(".submit_prediction").click(function() {
    var that = $(this);
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
    return false;
  });  
});