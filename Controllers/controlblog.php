<?php
require_once("../Models/blogmodel.php");
class modeloControllerblog{
    private $model;
    function __construct(){
        $this-> model = new Modeloblog();
    }
    static function blog(){
        $pblog = new Modeloblog();
        $datoblog = $pblog->mostrarBlog();
        return $datoblog;
    }
    static function blogprincipal(){
        $pblog = new Modeloblog();
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
        $pblog = new Modeloblog();
        $exito = $pblog->guardarPost($titulo, $mensaje, $iduser, $lugar, $img);
        if ($exito) {
            header("Location: http://localhost/proyecto_Lenguajes/Views/adminblog.php");
            exit(); 
        } else {
            echo($exito);
        }
    }
    public function eliminar($id) {
        $modelo = new Modeloblog();
        $modelo->eliminarBlog($id);
    }
    public function obtenerPostPorID($id) {
        $modelo = new Modeloblog();
        return $modelo->obtenerPostPorID($id);
    }
    public function actualizarPost($id, $titulo, $mensaje, $destino) {
        $modelo = new Modeloblog();
        $modelo->actualizarPost($id, $titulo, $mensaje, $destino);
    }
}