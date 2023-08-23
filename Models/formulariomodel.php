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

    function mostrarSolicitud($ID_USER_SOLICITUD,$FULLNAME,$EMAIL,$PHONE, $SERVICIO,$MENSAJE){
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
            $query = "select * from solicitud where ID_USER_SOLICITUD = :ID_USER_SOLICITUD";
            $stmt = $this -> db -> prepare($query);
            $stmt -> execute([':ID_USER_SOLICITUD' => $ID_USER_SOLICITUD]);
            $solicitud = $stmt->fetch(PDO::FETCH_ASSOC);
            return $solitud;
        } catch (PDOException $e){
            return null;
        }
    }

    ?>