$(document).ready(function() {
    console.log('ready');
    init();
});

function init(){
   onshowmodalinfo();
}

function onshowmodalinfo() {
    
    $('#modalinfo').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var idplaya = button.data('idplaya')
        var nombreplaya = button.data('nombreplaya')
        
        $.ajax({
            type: "GET",
            url: "Controller?op=info&idplaya="+idplaya+"&nombreplaya="+nombreplaya,
            success : function(info) {
                    $("#modalinfo .modal-body").html(info);
            }
        })
        
    })
}

