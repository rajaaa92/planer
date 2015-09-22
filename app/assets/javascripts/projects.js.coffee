$(document).ready ->
  $('#main_projects_list').sortable(
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  )

