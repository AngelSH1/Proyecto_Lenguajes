<?php
    include_once "connection.php";
    
    function RegistrarUsuario($NAME, $LAST_NAME, $EMAIL, $PHONE, $PASSWORD)
    {
        try
        {
        $enlace = OpenBD();
        $sentencia = oci_parse($enlace, 'BEGIN RegistrarUsuario(:NAME, :LAST_NAME, :EMAIL, :PHONE, :PASSWORD); END;');
        oci_bind_by_name($sentencia, ':NAME', $NAME);
        oci_bind_by_name($sentencia, ':LAST_NAME', $LAST_NAME);
        oci_bind_by_name($sentencia, ':EMAIL', $EMAIL);
        oci_bind_by_name($sentencia, ':PHONE', $PHONE);
        oci_bind_by_name($sentencia, ':PASSWORD', $PASSWORD);
        $respuesta = oci_execute($sentencia);
        CloseBD($enlace);

        return $respuesta;
    }
    catch(Exception $e){
        return false; 
    }
    }

    ?>