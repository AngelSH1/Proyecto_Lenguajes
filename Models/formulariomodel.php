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

    function borrarSolictud($p_id_solicitud){
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
        try {
            $enlace = openBD();
            $query = "select * from solicitud where ID_USER_SOLICITUD = :ID_USER_SOLICITUD";
            $stmt = oci_parse($enlace, $query);
            oci_bind_by_name($stmt, ':ID_USER_SOLICITUD', $ID_USER_SOLICITUD);
            oci_execute($stmt);
            $solicitud = oci_fetch_assoc($stmt);
            CloseBD($enlace);
            return $solicitud;
        } catch (PDOException $e) {
            return null;
        }
    }
    
      

    ?>