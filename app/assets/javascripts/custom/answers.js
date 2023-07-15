function deleteItem (button) { // eslint-disable-line no-unused-vars
  const inline = button.parentNode
  const formCheck = inline.parentNode
  const col = formCheck.parentNode
  col.removeChild(formCheck)
  const item = formCheck.getElementsByClassName('form-check-label')[0].textContent
  $.post('/answers/remove', { item }) /* eslint-env jquery */
}
