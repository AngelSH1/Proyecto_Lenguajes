<?php
require_once("Model/index.php");
class modeloController{
    private $model;
    function __construct(){
        $this-> model = new Modelo();
    }
    static function index(){
        $productos = new Modelo();
        $dato= $productos->mostrar("DESTINATIONS");
        require_once("Views/index.php");
    }
}