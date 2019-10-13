$(document).on("turbolinks:load", function() {
  $("#follow form").on("ajax:success", function() {
    var form = $("#follow form")
    var submit = $("#follow form input[type='submit']").remove()
    if (submit.prop("class") === "btn btn-primary"){
      form.append("<input type='hidden' name='_method' value='delete'>")
      form.append("<input type='submit' name='commit' value='フォロー解除' class='btn btn-danger' data-disable-with='フォロー解除'></input>")
    } else {
      $("#follow form input[value='delete']").remove();
      form.append("<input type='submit' name='commit' value='フォローする' class='btn btn-primary' data-disable-with='フォローする'>")
    }
  })
})

