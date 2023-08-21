<?php
    include_once "connection.php";
class Modelo{
    private $Modelo;
    private $db;
    private $personas;
    private $guias;
    public function __construct(){
        $this-> Modelo=array();
        $this-> db = new PDO('oci:dbname=//localhost:1521/orcl;charset=UTF8', "ADMIN", "ADMIN");
    }
    
    public function mostrar($tabla){
        $consul="select * from DESTINATIONS";
        $resu=$this->db->query($consul);
        $filas=$resu->fetchAll(PDO::FETCH_ASSOC);
        $this->personas[]=$filas;        
        return $this->personas;

    }

    public function buscarGuias($tabla) {
        $consul = "select * from GUIDES";
        $resu = $this->db->query($consul);
        $filas = $resu->fetchAll(PDO::FETCH_ASSOC);
        $this->guias[] = $filas;        
        return $this->guias;
    }

    public function insertar($tabla, $data) {
        $columnas = implode(', ', array_keys($data));
        $valores = ':' . implode(', :', array_keys($data));
        
        $consulta = "INSERT INTO $tabla ($columnas) VALUES ($valores)";
        $consulta= 'commit';
        $stmt = $this->db->prepare($consulta);
    
        foreach ($data as $key => $value) {
            $stmt->bindValue(':' . $key, $value);
        }
    
        try {
            $stmt->execute();
            return true;
        } catch (PDOException $e) {
            echo "Error al guardar los datos: " . $e->getMessage();
            return false;
        }
    }

}