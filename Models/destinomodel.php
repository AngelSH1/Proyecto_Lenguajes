<?php
    include_once "connection.php";
class Modelodestino{
    private $Modelo;
    private $db;
    private $personas;
    private $guias;

    public function __construct(){
        $this-> Modelo=array();
        $this-> db = new PDO('oci:dbname=//localhost:1521/orcl;charset=UTF8', "ADMIN", "ADMIN");
    }
    public function mostrardestinos() {
        $conn = OpenBD();
        $sql = "BEGIN PAQUETE_DESTINATIONS.VER_TODOS_DESTINATIONS(:result); END;";
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
    public function mostrardestinousuarios() {
        $conn = OpenBD();
        $sql = "BEGIN PAQUETE_DESTINATIONS.VER_DESTINATION_GUIDE(:result); END;";
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
    public function guardarDestino($titulo, $mensaje, $finicio, $ffin, $espacios, $guia, $precio, $img) {
        $conn = OpenBD();
        $finicio = $_REQUEST['start_date'];
        $ffin = $_REQUEST['end_date'];

        // Convertir el formato 
        $finicio = date('d/m/y', strtotime($finicio));
        $ffin = date('d/m/y', strtotime($ffin));

        $sql = "BEGIN PAQUETE_DESTINATIONS.INSERTAR_DESTINATION(:p_titulo, :p_mensaje, :p_finicio, :p_ffin, :p_espacios, :p_guia, :p_precio, :p_img); END;";
        $stmt = oci_parse($conn, $sql);
        oci_bind_by_name($stmt, ":p_titulo", $titulo);
        oci_bind_by_name($stmt, ":p_mensaje", $mensaje);
        oci_bind_by_name($stmt, ":p_finicio", $finicio);
        oci_bind_by_name($stmt, ":p_ffin", $ffin);
        oci_bind_by_name($stmt, ":p_espacios", $espacios);
        oci_bind_by_name($stmt, ":p_guia", $guia);
        oci_bind_by_name($stmt, ":p_precio", $precio);
        
        // Si $img contiene un valor válido, crea un descriptor BLOB
        if ($img !== null) {
            $blob = oci_new_descriptor($conn, OCI_D_LOB);
            $blob->writeTemporary($img, OCI_TEMP_BLOB);
            oci_bind_by_name($stmt, ":p_img", $blob, -1, OCI_B_BLOB);
        } else {
            $blob = null;
            oci_bind_by_name($stmt, ":p_img", $blob, -1, OCI_B_BLOB);
        }
        try {
            $result = oci_execute($stmt);
            // Liberar el descriptor BLOB si se utilizó
            if ($blob !== null) {
                $blob->free();
            }
            CloseBD($conn); 
        } catch (SQLException $e) {
            echo "Error al guardar los datos: " . $e->getMessage();
        }
        return $result;
    }
    public function eliminarDestino($id) {
        $conn = OpenBD();
        $sql = "BEGIN PAQUETE_DESTINATIONS.ELIMINAR_DESTINATION(:id); END;";
        $stmt = oci_parse($conn, $sql);
        oci_bind_by_name($stmt, ":id", $id);
        oci_execute($stmt);
        oci_commit($conn); 
        CloseBD($conn);
    }
    public function obtenerdestinoid($id) {
        $conn = OpenBD();
        $sql = "BEGIN PAQUETE_DESTINATIONS.VER_DESTINO_ID(:id, :result); END;";
        $stmt = oci_parse($conn, $sql);
        oci_bind_by_name($stmt, ":id", $id);
        $result = oci_new_cursor($conn);
        oci_bind_by_name($stmt, ":result", $result, -1, OCI_B_CURSOR);
        oci_execute($stmt);
        oci_execute($result);

        $post = oci_fetch_assoc($result);
        oci_free_statement($stmt);
        oci_free_statement($result);
        CloseBD($conn);

        return $post;
    }
    public function actualizarDestino($id, $titulo, $mensaje, $start_date, $end_date, $espacios, $guia, $precio) {
        $conn = OpenBD();
        $start_date = $_REQUEST['start_date'];
        $end_date = $_REQUEST['end_date'];
        // Convertir el formato 
        $start_date = date('d/m/y', strtotime($start_date));
        $end_date = date('d/m/y', strtotime($end_date));

        $sql = "BEGIN PAQUETE_DESTINATIONS.MODIFICAR_DESTINATION(:p_id, :p_titulo, :p_mensaje, :p_start_date, :p_end_date, :p_espacios, :p_guia, :p_precio); END;";
        $stmt = oci_parse($conn, $sql);
        oci_bind_by_name($stmt, ":p_id", $id);
        oci_bind_by_name($stmt, ":p_titulo", $titulo);
        oci_bind_by_name($stmt, ":p_mensaje", $mensaje);
        oci_bind_by_name($stmt, ":p_start_date", $start_date);
        oci_bind_by_name($stmt, ":p_end_date", $end_date);
        oci_bind_by_name($stmt, ":p_espacios", $espacios);
        oci_bind_by_name($stmt, ":p_guia", $guia);
        oci_bind_by_name($stmt, ":p_precio", $precio);
        
        try {
            $result = oci_execute($stmt);
            CloseBD($conn);
        } catch (SQLException $e) {
            echo "Error al actualizar los datos: " . $e->getMessage();
        }
        return $result;
    }

}