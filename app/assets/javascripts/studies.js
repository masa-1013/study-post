jQuery(function($) {
  $("form").on("submit", function() {
    if ($("#comment_content").val() === "") {
      alert("コメントを入力して下さい")
      return false;
    }
  })
})