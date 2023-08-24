<?php
include_once "connection.php";
include_once "C:/xampp/htdocs/Proyecto_Lenguajes/Views/layout.php";
?>

<!DOCTYPE html>
<html lang="en">
<head>
<title>BLOG</title>
    <?php MostrarHead(); ?>
    <link rel="stylesheet" href="../Views/Assets/css/estilos.css">
</head>
<body>

<?php 

        MostrarHeader();
    ?>
<div class="container-all" id="move-content">

    
<div class="container-cover">
    <div class="container-info-cover">
        <h1>¡Todo es posible!</h1>
        <p>Somos una compañia familiar apasionada por los viajes</p>
    </div>
</div>
<div class="header"><br>
    <h1>SOLICITUDES REGISTRADAS</h1>
</div>
<div class="grid-container">
<?php

function mostrarSolicitudes() {
    try {
        $enlace = OpenBD();
        $query = 'BEGIN VER_SOLICITUD(:cursor); END;';
        $stmt = oci_parse($enlace, $query);
        $cursor = oci_new_cursor($enlace);
        oci_bind_by_name($stmt, ':cursor', $cursor, -1, OCI_B_CURSOR);
        oci_execute($stmt);
        oci_execute($cursor);
        
        while (($row = oci_fetch_assoc($cursor)) !== false) {
            echo "<p>";
            echo "<STRONG>ID_SOLICITUD: </STRONG>" . $row['ID_SOLICITUD'] . "<br>";
            echo "<STRONG>ID_USER_SOLICITUD: </STRONG>" . $row['ID_USER_SOLICITUD'] . "<br>";
            echo "<STRONG>FULLNAME: </STRONG>" . $row['FULLNAME'] . "<br>";
            echo "<STRONG>EMAIL: </STRONG>" . $row['EMAIL'] . "<br>";
            echo "<STRONG>PHONE: </STRONG>" . $row['PHONE'] . "<br>";
            echo "<STRONG>SERVICIO: </STRONG>" . $row['SERVICIO'] . "<br>";
            echo "<STRONG>MENSAJE: </STRONG>" . $row['MENSAJE'] . "<br>";
            echo "<td><a href='editar.php?ID_SOLICITUD=" . $row['ID_SOLICITUD'] . "'>Editar</a></td>" . "<br>";
            echo "<td><a href='borrar.php?ID_SOLICITUD=" . $row['ID_SOLICITUD'] . "'>Borrar</a></td>". "<br><br>";
            echo "<br>";
            echo "</p>";
        }
        oci_free_statement($stmt);
        oci_free_cursor($cursor);
        CloseBD($enlace);
    } catch (PDOException $e) {
        
    }
}

mostrarSolicitudes();
echo "<br><br><br>";

?>
