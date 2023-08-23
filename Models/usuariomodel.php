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

    function ValidarSesion($Correo, $Contrasenna)
    {
        try 
        {
            $enlace = OpenBD();
            $sentencia = oci_parse($enlace, 'BEGIN ValidarSesion(:EMAIL, :PASSWORD, :RESULTADO); END;');
            oci_bind_by_name($sentencia, ':EMAIL', $Correo);
            oci_bind_by_name($sentencia, ':PASSWORD', $Contrasenna);
            oci_bind_by_name($sentencia, ':RESULTADO', $resultado, 1); // El tercer parámetro 1 indica que es un parámetro de salida
            oci_execute ($sentencia);
            CloseBD($enlace);
    
            return $resultado;
        }
        catch(Exception $e){
            return false; 
        }
    }

    ?>