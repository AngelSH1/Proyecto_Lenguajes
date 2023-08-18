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

    public function mostrarBlog1($tabla){
        $consul = "SELECT * FROM \"$tabla\"";
        $resu=$this->db->query($consul);
        $filas=$resu->fetchAll(PDO::FETCH_ASSOC);
        $this->personas[]=$filas;
        
        return $this->personas;

    }

    public function mostrarBlog() {
        $conn = OpenBD();
        $sql = "BEGIN PAQUETE_BLOG.VER_BLOG(:result); END;";
        $stmt = oci_parse($conn, $sql);
        $result = oci_new_cursor($conn);
        oci_bind_by_name($stmt, ":result", $result, -1, OCI_B_CURSOR);
        oci_execute($stmt);
        oci_execute($result);
        $rows = array();
        while ($row = oci_fetch_assoc($result)) {
            $rows[] = $row;
        }
        oci_free_statement($stmt);
        oci_free_statement($result);
        CloseBD($conn);
        return $rows;
    }
    public function mostrarBlogPrincipal() {
        $conn = OpenBD();
        $sql = "BEGIN VER_BLOG_PRINCIPAL(:result); END;";
        $stmt = oci_parse($conn, $sql);
        $result = oci_new_cursor($conn);
        oci_bind_by_name($stmt, ":result", $result, -1, OCI_B_CURSOR);
        oci_execute($stmt);
        oci_execute($result);
        $rows = array();
        while ($row = oci_fetch_assoc($result)) {
            $rows[] = $row;
        }
        oci_free_statement($stmt);
        oci_free_statement($result);
        CloseBD($conn);
        return $rows;
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
    public function insertar2($tabla, $data) {
        $conn = OpenBD();
        $sql = "INSERT INTO BLOG_ENTRY (TITLE, DESCRIPTION, ID_USER, ID_DESTINATION, IMAGE1) VALUES ($data)";
        $stmt = oci_parse($conn, $sql);
        
        try {
            $result = oci_execute($stmt);
            CloseBD($conn); 
        } catch (SQLException $e) {
            echo "Error al guardar los datos: " . $e->getMessage();
        }
        return $result;
    }
    public function guardarPost($titulo, $mensaje, $iduser, $lugar, $img) {
        $conn = OpenBD();
        $sql = "BEGIN INSERTAR_POST(:p_titulo, :p_mensaje, :p_iduser, :p_lugar, :p_img); END;";
        $stmt = oci_parse($conn, $sql);
        oci_bind_by_name($stmt, ":p_titulo", $titulo);
        oci_bind_by_name($stmt, ":p_mensaje", $mensaje);
        oci_bind_by_name($stmt, ":p_iduser", $iduser);
        oci_bind_by_name($stmt, ":p_lugar", $lugar);
        $blob = oci_new_descriptor($conn, OCI_D_LOB);
        $blob->writeTemporary($img, OCI_TEMP_BLOB);
        oci_bind_by_name($stmt, ":p_img", $blob, -1, OCI_B_BLOB);
        try {
            $result = oci_execute($stmt);
            $blob->free();
            CloseBD($conn); 
        } catch (SQLException $e) {
            echo "Error al guardar los datos: " . $e->getMessage();
        }
        return $result;
    }
    
    

    

  
}