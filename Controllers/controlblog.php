<?php
require_once("../Models/index.php");
class modeloControllerblog{
    private $model;
    function __construct(){
        $this-> model = new Modelo();
    }
    static function blog(){
        $pblog = new Modelo();
        $datoblog = $pblog->mostrarBlog();
        return $datoblog;
    }
    static function blogprincipal(){
        $pblog = new Modelo();
        $datoblog = $pblog->mostrarBlogPrincipal();
        return $datoblog;
    }
    static function nuevo(){
        require_once("Views/post.php");
        
    }
    static function guardar() {
        $titulo = $_REQUEST['titulo'];
        $mensaje = $_REQUEST['mensaje'];
        $iduser = 1;
        $lugar = $_REQUEST['lugar'];
        $img = "EMPTY_BLOB()";
        $pblog = new Modelo();
        $exito = $pblog->guardarPost($titulo, $mensaje, $iduser, $lugar, $img);
        if ($exito) {
            header("Location: http://localhost/proyecto_Lenguajes/Views/adminblog.php");
            exit(); 
        } else {
            echo($exito);
        }
    }
    
}