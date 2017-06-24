$(document).ready(function(){
    $("#new_article").on("ajax:success", function(e, data, status, xhr){
      // $("#new_article").append xhr.responseText
      debugger
    }).on("ajax:error", function(e, xhr, status, error){
      console.log("Broke.")
    })
});