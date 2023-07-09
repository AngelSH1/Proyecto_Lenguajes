<?php
class Modelo{
    private $Modelo;
    private $db;
    private $personas;
    public function __construct(){
        $this-> Modelo=array();
        $this-> db = new PDO('oci:dbname=//localhost:1521/orcl;charset=UTF8', "ADMIN", "ADMIN");

    }
    public function mostrar($tabla){
        $consul="select * from V_DESTINATIONS";
        $resu=$this->db->query($consul);
        $filas=$resu->fetchAll(PDO::FETCH_ASSOC);
        $this->personas[]=$filas;
        
        return $this->personas;

    }
}