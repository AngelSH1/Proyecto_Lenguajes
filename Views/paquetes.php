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
?>
<!DOCTYPE html>
<html>
<head>
    <title>Información de los paquetes</title>
    <link rel="stylesheet" href="../Views/Assets/css/paquetes.css">
</head>
<body>
    <div class="main1">
    <h1>Información de los paquetes</h1>
    <table id="paquetes-table">
        <tr>
            <th>ID_PAQUETE</th>
            <th>TITULO_PAQUETE</th>
            <th>DESCRIPCION</th>
            <th>PRECIO</th>
        </tr>

        <?php foreach ($results as $row): ?>
            <tr>
                <td><?php echo $row['ID_PAQUETE']; ?></td>
                <td><?php echo $row['TITULO_PAQUETE']; ?></td>
                <td><?php echo $row['DESCRIPCION']; ?></td>
                <td><?php echo $row['PRECIO']; ?></td>
            </tr>
        <?php endforeach; ?>
    </table>
    </div>
    
</body>
</html>
