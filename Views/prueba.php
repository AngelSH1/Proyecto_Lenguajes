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
?>
