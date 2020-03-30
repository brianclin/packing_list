// 'rgb(139, 166, 218)' dark blue
// '#97d2ff' light blue
function toggleButton(button, text, id) {
    text = text.replace(/"/g, '')
    if(button.style.backgroundColor == 'lightgray') {
        if (button.classList.contains('dropdown-item')) {
            button.setAttribute('style', "background-color: '' !important");
            button.style.opacity = "1";
            buttons = button.parentElement.children;
            change = true;
            for (button of buttons) {
                if (button.nodeName == "BUTTON" && button.style.backgroundColor != '') {
                    change = false;
                }
            }
            if (change) {
                button.closest('div.dropdown-menu').previousElementSibling.setAttribute('style', "background-color: #97d2ff !important");
            }
            $.post( "/answers/remove", { text: text, id: id} );
        }
    }
    else if(button.style.backgroundColor == 'rgb(139, 166, 218)') {
        button.setAttribute('style', "background-color: #97d2ff !important");
        $.post( "/answers/remove", { text: text, id: id} );
    }
    else {
        if(button.classList.contains('dropdown-item')) {
            button.setAttribute('style', "background-color: lightgray !important");
            button.closest('div.dropdown-menu').previousElementSibling.setAttribute('style', "background-color: rgb(139, 166, 218) !important");
        }
        else
            button.setAttribute('style', "background-color: rgb(139, 166, 218) !important");
        $.post( "/answers", { text: text, id: id} );
    }
    setTimeout(function(){document.getElementById('packing_list').contentWindow.location.reload(true);}, 100)
}
