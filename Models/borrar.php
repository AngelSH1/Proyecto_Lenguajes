<?php
include_once "connection.php";
include_once "formulariomodel.php";

// Obtener el ID de la solicitud de la URL
$p_id_solicitud = $_GET['ID_SOLICITUD'];

// Llamar a la función para borrar la solicitud
borrarSolictud($p_id_solicitud);

// Redireccionar de regreso a la lista de solicitudes
header("Location: solicitudes.php");
exit;
?>
