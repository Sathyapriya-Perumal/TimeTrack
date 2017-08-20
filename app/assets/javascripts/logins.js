$(document).ready(function(){
  $('.clockin').click(function(){
    $.ajax({
      url: "/login/clockin",
      method: "GET",
      success: function(){
        location.reload(true);
      }
    });
    event.preventDefault();
  });
});
