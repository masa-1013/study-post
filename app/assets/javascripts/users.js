$(document).on("turbolinks:load", function() {
  $("#follow form").on("ajax:success", function() {
    var form = $("#follow form")
    var submit = $("#follow form input[type='submit']").remove()
    var count = parseInt($("#followers_count").text(), 10)
    if (submit.prop("class") === "btn btn-primary"){
      form.append("<input type='hidden' name='_method' value='delete'>")
      form.append("<input type='submit' name='commit' value='フォロー解除' class='btn btn-danger' data-disable-with='フォロー解除'></input>")
      debugger
      count += 1
    } else {
      $("#follow form input[value='delete']").remove();
      form.append("<input type='submit' name='commit' value='フォローする' class='btn btn-primary' data-disable-with='フォローする'>")
      count -= 1
    }
    $("#followers_count").text(count)
  })
})

