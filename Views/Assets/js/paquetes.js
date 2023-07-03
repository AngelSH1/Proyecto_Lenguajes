$(document).ready(function() {
    // Realizar la solicitud AJAX al archivo PHP
    $.ajax({
        url: '../Controllers/paquetes.php',
        dataType: 'json',
        success: function(data) {
            // Recorrer los datos y agregar filas a la tabla
            $.each(data, function(index, item) {
                var row = '<tr>' +
                    '<td>' + item.ID_PAQUETE + '</td>' +
                    '<td>' + item.TITULO_PAQUETE + '</td>' +
                    '<td>' + item.DESCRIPCION + '</td>' +
                    '<td>' + item.PRECIO + '</td>' +
                    '</tr>';

                $('#paquetes-table').append(row);
            });
        },
        error: function() {
            // Manejar el error de la solicitud AJAX
            alert('Error al obtener los datos de los paquetes');
        }
    });
});