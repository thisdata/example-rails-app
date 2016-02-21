# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#user_email").on "keyup", () ->
    value = $(@).val()
    name_and_domain = value.split("@")
    name_parts = name_and_domain[0].split(".")
    name = for part in name_parts
      part.substr(0,1).toUpperCase() + part.substr(1)

    $("#user_name").val(name.join(" "))


