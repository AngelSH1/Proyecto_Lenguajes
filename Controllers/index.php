<?php
require_once("Models/index.php");
class modeloController{
    private $model;
    function __construct(){
        $this-> model = new Modelo();
    }
    static function index(){
        $productos = new Modelo();
        $dato= $productos->mostrar("DESTINATIONS");
        require_once("Views/index2.php");
    }
    static function index2(){
        $productos = new Modelo();
        $dato= $productos->mostrar("DESTINATIONS");
        require_once("Views/PaquetesAdmin.php");
    }

    static function nuevo() {
        $guias = new Modelo();
        $datosGuias = $guias->buscarGuias("GUIDES");
        require_once("Views/AgregarDestino.php");
    }
    static function guardar(){
            $title = $_REQUEST['title'];
            $description = $_REQUEST['description'];
            $start_date = $_REQUEST['start_date'];
            $end_date = $_REQUEST['end_date'];
            $spaces = $_REQUEST['spaces'];
            $guide = $_REQUEST['guide'];
            $price = $_REQUEST['price'];
            $data = "'" . $title . "','" . $description . "','" . $start_date . "','" . $end_date . "'," . $spaces . ",'" . $guide . "'," . $price;
            $producto = new Modelo();
            $dato= $producto->insertar("DESTINATIONS",$data);
            header("location:".urlsite);
        
    }
}