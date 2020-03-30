function deleteItem (button) { // eslint-disable-line no-unused-vars
  var inline = button.parentNode
  var formCheck = inline.parentNode
  var col = formCheck.parentNode
  col.removeChild(formCheck)
  var item = formCheck.getElementsByClassName('form-check-label')[0].textContent
  $.post('/answers/remove', { item: item }) /* eslint-env jquery */
}
