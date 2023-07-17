<?php
require_once("Models/index.php");
class modeloControllerblog{
    private $model;
    function __construct(){
        $this-> model = new Modelo();
    }
    static function blog(){
        $pblog = new Modelo();
        $datoblog = $pblog->mostrarBlog("BLOG_ENTRY");
        require_once("Views/adminblog.php");
        
    }
    static function nuevo(){
        require_once("Views/post.php");
        
    }
    static function guardar(){
        $titulo = $_REQUEST['titulo'];
        $mensaje = $_REQUEST['mensaje'];
        $iduser = 1;
        $lugar = $_REQUEST['lugar'];
        $img = "EMPTY_BLOB()";
        $data = "'" . $titulo . "','" . $mensaje . "'," . $iduser . "," . $lugar . "," . $img;
        $pblog = new Modelo();
        $exito = $pblog->insertar2("BLOG_ENTRY", $data);
        if ($exito) {
            header("Location: " . urlsite);
        } else {
            // Hubo un error en la inserción
            // Manejar el error aquí
        }
    }
}