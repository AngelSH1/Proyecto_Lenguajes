<?php
    include_once "connection.php";
class Modeloblog{
    private $Modelo;
    private $db;
    private $personas;
    private $guias;
    public function __construct(){
        $this-> Modelo=array();
        $this-> db = new PDO('oci:dbname=//localhost:1521/orcl;charset=UTF8', "ADMIN", "ADMIN");
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
        $sql = "BEGIN PAQUETE_BLOG.VER_BLOG_PRINCIPAL(:result); END;";
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
    public function guardarPost($titulo, $mensaje, $iduser, $lugar, $img) {
        $conn = OpenBD();
        $sql = "BEGIN PAQUETE_BLOG.INSERT_BLOG_ENTRY(:p_titulo, :p_mensaje, :p_iduser, :p_lugar, :p_img); END;";
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
    public function eliminarBlog($id) {
        $conn = OpenBD();
        $sql = "BEGIN PAQUETE_BLOG.DELETE_BLOG_ENTRY(:id); END;";
        $stmt = oci_parse($conn, $sql);
        oci_bind_by_name($stmt, ":id", $id);
        oci_execute($stmt);
        oci_commit($conn); 
        CloseBD($conn);
    }
    

    

  
}