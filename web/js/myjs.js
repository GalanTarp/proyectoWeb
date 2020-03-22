$(document).ready(function () {
    console.log('ready')
    init()
});

function init() {
     // Listener
    loadReservas()
    loadDatePicker()
}

function loadReservas() {
    $('#modalpeliculas').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget)
        var nhabitacion = button.data('id')
        console.log('hab' + nhabitacion)
        $.ajax({
            type: "GET",
            url: "Controller?op=reservas&nhabitacion=" + nhabitacion,
            success: function (info) {
                $("#reservas").html(info)
            }
        })
    })
}
function loadDatePicker(){
    $("#datepicker").datepicker({
        dateFormat: "dd-mm-yy"
    });
}