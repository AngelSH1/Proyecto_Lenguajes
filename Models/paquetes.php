<?php
class Modelo{
    private $Modelo;
    private $db;
    private $personas;
    public function __construct(){
        $this->Modelo=array();
        $this->db= new PDO("oci:dbname=//localhost:1521/orcl",'ADMIN','ADMIN');
    }
    public function mostrar($tabla,$condicion){
        $consul= "SELECT * FROM ".$tabla." where ".$condicion.";";
        $resu=$this->db->query($consul);
        while($filas = $resu->fetchAll(PDO::FETCH_ASSOC)){
            $this->personas[]=$filas;
        }
        return $this->personas;

    }
}