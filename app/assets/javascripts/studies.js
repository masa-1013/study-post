document.addEventListener("DOMContentLoaded", function() {
  document.getElementById("comment_content").addEventListener("blur", function() {
    var text = document.getElementById("comment_content")
    var button = document.getElementById("submit_button")
    button.disabled = text.value === "" ? true : false
  })
})
