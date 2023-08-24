<?php
    include_once "connection.php";
    
    function RegistrarFormulario($ID_USER_SOLICITUD, $FULLNAME, $EMAIL, $PHONE, $SERVICIO, $MENSAJE)
    {
        try
        {
        $enlace = OpenBD();
        $sentencia = oci_parse($enlace, 'BEGIN RegistrarFormulario(:ID_USER_SOLICITUD, :FULLNAME, :EMAIL, :PHONE, :SERVICIO, :MENSAJE); END;');
        oci_bind_by_name($sentencia, ':ID_USER_SOLICITUD', $ID_USER_SOLICITUD);
        oci_bind_by_name($sentencia, ':FULLNAME', $FULLNAME);
        oci_bind_by_name($sentencia, ':EMAIL', $EMAIL);
        oci_bind_by_name($sentencia, ':PHONE', $PHONE);
        oci_bind_by_name($sentencia, ':SERVICIO', $SERVICIO);
        oci_bind_by_name($sentencia, ':MENSAJE', $MENSAJE);
        $respuesta = oci_execute($sentencia);
        CloseBD($enlace);

        return $respuesta;
    }
    catch(Exception $e){
        return false; 
    }
    }

    function editarSolicitud($ID_USER_SOLICITUD,$FULLNAME,$EMAIL,$PHONE, $SERVICIO,$MENSAJE){
        try {
            $enlace = openBD();
            $query = oci_parse($enlace, 'BEGIN
            PAQUETE_SOLICITUD.EDITAR_SOLICITUD(
                p_id_solicitud => :p_id_solicitud,
                p_id_user_solicitud => :p_id_user_solicitud,
                p_fullname => :p_fullname,
                p_email => :p_email,
                p_phone => :p_phone,
                p_servicio => :p_servicio,
                p_mensaje => :p_mensaje);
            COMMIT;
        END;');

        oci_bind_by_name($query, ':ID_USER_SOLICITUD', $ID_USER_SOLICITUD);
        oci_bind_by_name($query, ':FULLNAME', $FULLNAME);
        oci_bind_by_name($query, ':EMAIL', $EMAIL);
        oci_bind_by_name($query, ':PHONE', $PHONE);
        oci_bind_by_name($query, ':SERVICIO', $SERVICIO);
        oci_bind_by_name($query, ':MENSAJE', $MENSAJE);
        $respuesta = oci_execute($query);
        CloseBD($enlace);

        return $respuesta;
        } catch (PDOException $e) {
            return null;
        }
    }

    function borrarSolictud($ID_USER_SOLICITUD){
        $enlace = openBD();
        $query = oci_parse($enlace, 'BEGIN
        PAQUETE_SOLICITUD.ELIMINAR_SOLICITUD(
            p_id_solicitud => :p_id_solicitud
        );
        COMMIT;
    END;');
    oci_bind_by_name($query, ':p_id_solicitud', $p_id_solicitud);
    $respuesta = oci_execute($query);
    CloseBD($enlace);
    }

    function buscarSolicitud($ID_USER_SOLICITUD){
        try{
            $enlace = openBD();
            $query = "select * from solicitud where ID_USER_SOLICITUD = :ID_USER_SOLICITUD";
            $stmt = $this -> db -> prepare($query);
            $stmt -> execute([':ID_USER_SOLICITUD' => $ID_USER_SOLICITUD]);
            $solicitud = $stmt->fetch(PDO::FETCH_ASSOC);
            return $solitud;
        } catch (PDOException $e){
            return null;
        }
    }

    function mostrarSolicitud(){
        $enlace = OpenBD();
        $sql = "SET SERVEROUTPUT ON;
        DECLARE
            v_id_solicitud NUMBER;
            v_id_user_solicitud NUMBER;
            v_fullname VARCHAR2(50);
            v_email VARCHAR2(50);
            v_phone VARCHAR2(50);
            v_servicio VARCHAR2(50);
            v_mensaje VARCHAR2(100);
        BEGIN
            FOR solicitud IN (SELECT * FROM SOLICITUd) LOOP
                v_id_solicitud := solicitud.ID_SOLICITUD;
                v_id_user_solicitud := solicitud.ID_USER_SOLICITUD;
                v_fullname := solicitud.FULLNAME;
                v_email := solicitud.EMAIL;
                v_phone := solicitud.PHONE;
                v_servicio := solicitud.SERVICIO;
                v_mensaje := solicitud.MENSAJE;
                
                DBMS_OUTPUT.PUT_LINE('ID Solicitud: ' || v_id_solicitud || ', id_user_solicitud: ' || v_id_user_solicitud ||', Nombre: ' || v_fullname || ', Email: ' || v_email);
            END LOOP;
        END;";
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
        

    ?>