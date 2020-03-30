function deleteItem(button) {
    inline = button.parentNode
    formCheck = inline.parentNode
    col = formCheck.parentNode
    col.removeChild(formCheck)
    item = formCheck.getElementsByClassName("form-check-label")[0].textContent
    $.post( "/answers/remove", { item: item} )
}
