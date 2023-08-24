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
    <style>
        .edit-form {
    width: 1000px;
    margin: auto;
    padding: 20px;
    background-color: #f2f2f2;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
}

.form-group textarea {
    height: 100px;
}




    </style>
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
<h1>EDITAR SOLICITUD REGISTRADA</h1>
</div>
<div class="grid-container">

<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener los datos del formulario de edición
    $ID_SOLICITUD = $_POST['id_solicitud'];
    $ID_USER_SOLICITUD = $_POST['ID_USER_SOLICITUD'];
    $FULLNAME = $_POST['FULLNAME'];
    $EMAIL = $_POST['EMAIL'];
    $PHONE = $_POST['PHONE'];
    $SERVICIO = $_POST['SERVICIO'];
    $MENSAJE = $_POST['MENSAJE'];

    try {
        $enlace = OpenBD();
        $query = 'BEGIN PAQUETE_SOLICITUD.EDITAR_SOLICITUD(:p_id_solicitud, :p_id_user_solicitud, :p_fullname, :p_email, :p_phone, :p_servicio, :p_mensaje); END;';
        $stmt = oci_parse($enlace, $query);

        oci_bind_by_name($stmt, ':p_id_solicitud', $ID_SOLICITUD);
        oci_bind_by_name($stmt, ':p_id_user_solicitud', $ID_USER_SOLICITUD);
        oci_bind_by_name($stmt, ':p_fullname', $FULLNAME);
        oci_bind_by_name($stmt, ':p_email', $EMAIL);
        oci_bind_by_name($stmt, ':p_phone', $PHONE);
        oci_bind_by_name($stmt, ':p_servicio', $SERVICIO);
        oci_bind_by_name($stmt, ':p_mensaje', $MENSAJE);

        $resultado = oci_execute($stmt);
        CloseBD($enlace);

        if ($resultado) {
            echo "Solicitud editada exitosamente.";
            header("Location: solicitudes.php");
        } else {
            echo "Error al editar la solicitud.";
        }
    } catch (PDOException $e) {
        echo "Error de conexión o ejecución: " . $e->getMessage();
    }
}

// Obtener el ID de la solicitud de la URL
$idSolicitud = $_GET['ID_SOLICITUD'];

try {
    $enlace = OpenBD();
    $query = "SELECT * FROM SOLICITUD WHERE ID_SOLICITUD = :id_solicitud";
    $stmt = oci_parse($enlace, $query);
    oci_bind_by_name($stmt, ':id_solicitud', $idSolicitud);
    oci_execute($stmt);
    $solicitud = oci_fetch_assoc($stmt);
    CloseBD($enlace);

    if ($solicitud) {
        ?>
        <form class="edit-form" action="editar.php" method="post">
    <input type="hidden" name="id_solicitud" value="<?php echo $solicitud['ID_SOLICITUD']; ?>">
    <div class="form-group">
        <label for="ID_USER_SOLICITUD">ID_USER_SOLICITUD:</label>
        <input type="text" name="ID_USER_SOLICITUD" value="<?php echo $solicitud['ID_USER_SOLICITUD']; ?>">
    </div>
    <div class="form-group">
        <label for="FULLNAME">FULLNAME:</label>
        <input type="text" name="FULLNAME" value="<?php echo $solicitud['FULLNAME']; ?>">
    </div>
    <div class="form-group">
        <label for="EMAIL">EMAIL:</label>
        <input type="text" name="EMAIL" value="<?php echo $solicitud['EMAIL']; ?>">
    </div>
    <div class="form-group">
        <label for="PHONE">PHONE:</label>
        <input type="text" name="PHONE" value="<?php echo $solicitud['PHONE']; ?>">
    </div>
    <div class="form-group">
        <label for="SERVICIO">SERVICIO:</label>
        <input type="text" name="SERVICIO" value="<?php echo $solicitud['SERVICIO']; ?>">
    </div>
    <div class="form-group">
        <label for="MENSAJE">MENSAJE:</label>
        <textarea name="MENSAJE"><?php echo $solicitud['MENSAJE']; ?></textarea>
    </div>
    <div class="form-group">
        <input type="submit" value="Guardar cambios">
    </div>
</form>
        <?php
    } else {
        echo "No se encontraron resultados para la solicitud.";
    }
} catch (PDOException $e) {
    echo "Error de conexión o ejecución: " . $e->getMessage();
}
?>
