$(document).on("turbolinks:load", function() {
  $("form").on("submit", function() {
    if ($("#comment_content").val() === "") {
      alert("コメントを入力して下さい")
      return false
    }
  })
  $(".study .list-group-item").on("click", function(e) {
    if (e.target.id !== "user_link") {
      var id = $(this).parent().find("#study_id").val()
      location.href = "/studies/" + encodeURIComponent(id)
    } 
  })
})