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

    ?>