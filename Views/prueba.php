<?php
if (isset($_POST['btnpublicar']) && $_POST['btnpublicar'] === 'Guardar') {
    include_once("../Controllers/controlblog.php");
    include_once("../Models/index.php");

    modeloControllerblog::guardar();
}
?>
