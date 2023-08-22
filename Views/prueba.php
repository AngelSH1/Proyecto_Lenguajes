<?php

if (isset($_POST['btnpublicar']) && $_POST['btnpublicar'] === 'Guardar') {
    include_once("../Controllers/controlblog.php");
    modeloControllerblog::guardar();
}

if (isset($_GET['m']) && $_GET['m'] === 'eliminar' && isset($_GET['id'])) {
    include_once("../Controllers/controlblog.php");
    $id = $_GET['id'];
    $pblog = new modeloControllerblog();
    $pblog->eliminar($id);
    if ($pblog) {
        header("Location: http://localhost/proyecto_Lenguajes/Views/adminblog.php");
        exit(); 
    } else {
        echo($pblog);
    }
}
if (isset($_POST['m']) && $_POST['m'] === 'actualizar') {
    include_once("../Controllers/controlblog.php");
    $id = $_POST['id'];
    $titulo = $_POST['titulo'];
    $mensaje = $_POST['mensaje'];
    $destino = $_POST['Destino'];

    $pblog = new modeloControllerblog();
    
    try {
        $pblog->actualizarPost($id, $titulo, $mensaje, $destino);
        if ($pblog) {
            header("Location: http://localhost/proyecto_Lenguajes/Views/adminblog.php");
            exit(); 
        } else {
            echo($exito);
        }
    } catch (Exception $e) {
        echo "Error al actualizar los datos: " . $e->getMessage();
    }
    
}
?>
