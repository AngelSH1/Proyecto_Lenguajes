<?php
$host = 'localhost';
$port = 1521;
$dbName = 'ORCL';
$username = 'ADMIN';
$password = 'ADMIN';
$connectionString = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=$port))(CONNECT_DATA=(SID=$dbName)))";

// Establecer la conexión a la base de datos
$connection = oci_connect($username, $password, $connectionString);

if (!$connection) {
    $e = oci_error();
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}

$query = 'SELECT ID_PAQUETE, TITULO_PAQUETE, DESCRIPCION, PRECIO FROM ADMIN.PAQUETE';

$statement = oci_parse($connection, $query);
oci_execute($statement);

// Obtener los resultados de la consulta
$results = array();
while ($row = oci_fetch_assoc($statement)) {
    $results[] = $row;
}
oci_free_statement($statement);
oci_close($connection);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tabla de Paquetes</title>
    <!-- Importar Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="Views/Assets/css/paquetes.css" />
</head>
<body>
    <div class="container">
        <h1>Tabla de Paquetes</h1>
        <div class="grid-container">
            <?php foreach ($results as $paquete) { ?>
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><?php echo $paquete['TITULO_PAQUETE']; ?></h5>
                        <p class="card-text">Precio: <?php echo $paquete['PRECIO']; ?></p>
                        <a href="#" class="btn btn-primary">Más información</a>
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>

    <!-- Importar jQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>