<?php
require_once "../Proyecto_Lenguajes/Controllers/paquetes.php";

// Obtener la acción solicitada (si no se especifica, mostrar los DESTINATIONS por defecto)
$action = isset($_GET['action']) ? $_GET['action'] : 'showDestinations';

// Enrutar las solicitudes según la acción
switch ($action) {
    case 'showDestinations':
        $dato();
        break;
    // Otras acciones...
    default:
        $dato();
}
?>