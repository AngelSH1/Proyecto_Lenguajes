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
            $resultadosEncontrados = false;
            $enlace = OpenBD();
            $sentencia = oci_parse($enlace, 'BEGIN ValidarSesion(:EMAIL, :PASSWORD, :p_cursor); END;');
            oci_bind_by_name($sentencia, ':EMAIL', $Correo);
            oci_bind_by_name($sentencia, ':PASSWORD', $Contrasenna);
            $resultado = oci_new_cursor($enlace);
            oci_bind_by_name($sentencia, ':p_cursor', $resultado, -1, OCI_B_CURSOR); 
            oci_execute ($sentencia);
            oci_execute ($resultado);

            while (($row = oci_fetch_assoc($resultado)) !== false) {
                $resultadosEncontrados = true;
                $_SESSION["IdUsuario"] = $row["ID_USER"];  
                $_SESSION["NombreUsuario"] = $row["NAME"] . ' ' .  $row["LAST_NAME"] ;  
            }
            CloseBD($enlace);
    
            return $resultadosEncontrados;
        }
        catch(Exception $e){
            return false; 
        }
    }

    function ConsultaUsuario($IdUsuario)
    {
        try 
        {
            $enlace = OpenBD();
            $sentencia = oci_parse($enlace, 'BEGIN PAQUETE_USER.VER_USER_ID(:id_user, :cursor); END;');
            oci_bind_by_name($sentencia, ':id_user', $IdUsuario);
            $resultado = oci_new_cursor($enlace);
            oci_bind_by_name($sentencia, ':cursor', $resultado, -1, OCI_B_CURSOR); 
            oci_execute ($sentencia);
            oci_execute ($resultado);

            $post = oci_fetch_assoc($resultado);
            oci_free_statement($sentencia);
            oci_free_statement($resultado);
            CloseBD($enlace);

            return $post;

        }
        catch(Exception $e){
            return false; 
        }
    }

    function ActualizarUsuario($IdUsuario,$Nombre, $Apellido, $Telefono,$Email)
    {
        try
        {
            $enlace = OpenBD();
            $sentencia = oci_parse($enlace, 'BEGIN PAQUETE_USER.ACTUALIZAR_USER(:id_user, :name, :last_name, :email, :phone); END;');            
            oci_bind_by_name($sentencia, ':id_user', $IdUsuario);
            oci_bind_by_name($sentencia, ':name', $Nombre);
            oci_bind_by_name($sentencia, ':last_name', $Apellido);
            oci_bind_by_name($sentencia, ':email', $Email);
            oci_bind_by_name($sentencia, ':phone', $Telefono);
            $result = oci_execute($sentencia);
            CloseBD($enlace);

            return $result;
        }
        catch(Exception $e){
            return false; 
        }
    }




    ?>