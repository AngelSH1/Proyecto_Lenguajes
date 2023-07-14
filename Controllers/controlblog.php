<?php
require_once("Models/index.php");
class modeloControllerblog{
    private $model;
    function __construct(){
        $this-> model = new Modelo();
    }
    static function blog(){
        $pblog = new Modelo();
        $datoblog = $pblog->mostrarBlog("BLOG");
        require_once("Views/adminblog.php");
        
    }
}