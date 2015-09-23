$(document).ready ->
  if location.hash == ''
    $('html, body').animate { scrollTop: 0 }, 600

  $('.sign_in_button').click ->
    $('#myModal').modal('show')
