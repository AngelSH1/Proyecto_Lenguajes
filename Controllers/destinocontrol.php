<?php
require_once("../Models/destinomodel.php");
class modeloControllerdestinos{
    private $model;
    function __construct(){
        $this-> model = new Modelodestino();
    }
    static function destinos(){
        $pblog = new Modelodestino();
        $datoblog = $pblog->mostrardestinos();
        return $datoblog;
    }
    static function destinosprincipal(){
        $pblog = new Modelodestino();
        $datoblog = $pblog->mostrardestinousuarios();
        return $datoblog;
    }
    static function guardar() {
        $titulo = $_REQUEST['title'];
        $mensaje = $_REQUEST['description'];
        $finicio = $_REQUEST['start_date'];
        $ffin = $_REQUEST['end_date'];
        $espacios = $_REQUEST['spaces'];
        $guia = $_REQUEST['guide'];
        $precio = $_REQUEST['price'];
        $img = "EMPTY_BLOB()";
        $pblog = new Modelodestino();
        $exito = $pblog->guardarDestino($titulo, $mensaje, $finicio, $ffin, $espacios,$guia,$precio,$img);
        if ($exito) {
            header("Location: http://localhost/proyecto_Lenguajes/Views/admindestinos.php");
            exit(); 
        } else {
            echo($pblog);
        }
    }
    public function eliminar($id) {
        $modelo = new Modelodestino();
        $modelo->eliminarDestino($id);
    }
    public function obtenerdestinoPorID($id) {
        $modelo = new Modelodestino();
        return $modelo->obtenerdestinoid($id);
    }
    public function actualizarDestino($id, $titulo, $mensaje, $start_date, $end_date, $espacios, $guia, $precio) {
        $modelo = new Modelodestino();
        $modelo->actualizarDestino($id, $titulo, $mensaje, $start_date, $end_date, $espacios, $guia, $precio);
    }
    
}