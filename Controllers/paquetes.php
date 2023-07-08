<?php
require_once("../Models/paquetes.php");
class modeloController{
    private $model;
    public function __construct(){
        $this->model = new Modelo();
    }

    static function paquetes (){
        $paquetes = new Modelo();
        $dato = $paquetes->mostrar("DESTINATIONS","1");
        require_once("../Views/paquetes.php");
    }
}