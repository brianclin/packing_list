(function() {


}).call(this);
(function() {


}).call(this);
function deleteItem (button) { // eslint-disable-line no-unused-vars
  const inline = button.parentNode
  const formCheck = inline.parentNode
  const col = formCheck.parentNode
  col.removeChild(formCheck)
  const item = formCheck.getElementsByClassName('form-check-label')[0].textContent
  $.post('/answers/remove', { item }) /* eslint-env jquery */
};
// 'rgb(139, 166, 218)' dark blue
// '#97d2ff' light blue
function toggleButton (button, text, id) { // eslint-disable-line no-unused-vars
  text = text.replace(/"/g, '')
  if (button.style.backgroundColor === 'lightgray') {
    if (button.classList.contains('dropdown-item')) {
      button.setAttribute('style', "background-color: '' !important")
      button.style.opacity = '1'
      const buttons = button.parentElement.children
      let change = true
      for (button of buttons) {
        if (button.nodeName === 'BUTTON' && button.style.backgroundColor !== '') {
          change = false
        }
      }
      if (change) {
        button.closest('div.dropdown-menu').previousElementSibling.setAttribute('style', 'background-color: #97d2ff !important')
      }
      $.post('/answers/remove', { text, id }) /* eslint-env jquery */
    }
  } else if (button.style.backgroundColor === 'rgb(139, 166, 218)') {
    button.setAttribute('style', 'background-color: #97d2ff !important')
    $.post('/answers/remove', { text, id }) /* eslint-env jquery */
  } else {
    if (button.classList.contains('dropdown-item')) {
      button.setAttribute('style', 'background-color: lightgray !important')
      button.closest('div.dropdown-menu').previousElementSibling.setAttribute('style', 'background-color: rgb(139, 166, 218) !important')
    } else { button.setAttribute('style', 'background-color: rgb(139, 166, 218) !important') }
    $.post('/answers', { text, id }) /* eslint-env jquery */
  }
  setTimeout(function () { document.getElementById('packing_list').contentWindow.location.reload(true) }, 100)
};
(function() {


}).call(this);
(function() {


}).call(this);
(function() {


}).call(this);
(function() {


}).call(this);
(function() {


}).call(this);
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
;
