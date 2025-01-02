window.addEventListener("message", function(event) {
    let data = event.data;
    if (data.type === "open") {
        document.body.classList.add('visible'); 
        document.getElementById("container").classList.add('visible'); 
        document.getElementById("portocale").innerHTML = "Portocale: " + data.portocale; 
    }
});


$(document).ready(function(){
    document.onkeyup = function (data) {
        if (data.which == 27) { 
            document.body.classList.remove('visible'); 
            document.getElementById("container").classList.remove('visible'); 
            $.post('http://glb_questcraciun/inchide', JSON.stringify({})); 
        }
    };
});

function buy(nutecred, val) {
    $.post('http://glb_questcraciun/buy', JSON.stringify({val: val, men:nutecred}));
}
