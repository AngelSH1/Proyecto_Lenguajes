<?php
$host = 'localhost';
$port = 1521;
$dbName = 'ORCL';
$username = 'ADMIN';
$password = 'ADMIN';
$connectionString = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=$port))(CONNECT_DATA=(SID=$dbName)))";
$connection = oci_connect($username, $password, $connectionString);

if (!$connection) {
    $error = oci_error();
    echo "Error de conexión a la base de datos: " . $error['message'];
    exit();
}

$sql = "SELECT * FROM ADMIN.PAQUETE";
$statement = oci_parse($connection, $sql);
oci_execute($statement);

$results = array();
while ($row = oci_fetch_assoc($statement)) {
    $results[] = $row;
}

oci_close($connection);

// Convertir el arreglo en una cadena JSON
$jsonData = json_encode($results);

// Enviar la cadena JSON como respuesta
header('Content-Type: application/json');
echo $jsonData;
?>