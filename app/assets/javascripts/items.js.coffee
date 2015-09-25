$(document).ready ->
  $('#accordion').sortable(
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  )
