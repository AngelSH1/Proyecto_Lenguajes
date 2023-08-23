<?php
////////// para la accion de ingresar un blog
if (isset($_POST['btnpublicar']) && $_POST['btnpublicar'] === 'Guardar') {
    include_once("../Controllers/controlblog.php");
    modeloControllerblog::guardar();
}
///para eliminar un blog
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
///para actualizar un blog
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
/////Acciones de destinos

if (isset($_POST['btnpublicardestino']) && $_POST['btnpublicardestino'] === 'Guardar') {
    include_once("../Controllers/destinocontrol.php");
    modeloControllerdestinos::guardar();
}

if (isset($_GET['n']) && $_GET['n'] === 'eliminarDestino' && isset($_GET['id'])) {
    include_once("../Controllers/destinocontrol.php");
    $id = $_GET['id'];
    $pblog = new modeloControllerdestinos();
    $pblog->eliminar($id);
    if ($pblog) {
        header("Location: http://localhost/proyecto_Lenguajes/Views/admindestinos.php");
        exit(); 
    } else {
        echo($pblog);
    }

}
if (isset($_POST['n']) && $_POST['n'] === 'actualizar') {
    include_once("../Controllers/destinocontrol.php");
    $id = $_POST['id'];
    $titulo = $_POST['title'];
    $mensaje = $_POST['description'];
    $start_date = $_POST['start_date'];
    $end_date = $_POST['end_date'];
    $espacios = $_POST['spaces'];
    $guia = $_POST['guide'];
    $precio = $_POST['price'];

    $pblog = new modeloControllerdestinos();

    try {
        $pblog->actualizarDestino($id, $titulo, $mensaje, $start_date, $end_date, $espacios, $guia, $precio);
        header("Location: http://localhost/proyecto_Lenguajes/Views/destinos.php");
        exit();
    } catch (Exception $e) {
        echo "Error al actualizar los datos: " . $e->getMessage();
    }
}


?>
