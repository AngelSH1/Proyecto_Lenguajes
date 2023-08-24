<?php
    include_once "../Models/usuarioModel.php";

    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    
    if(isset($_POST["btnRegistro"]))
    {
        $NAME = $_POST["txtNombre"];
        $LAST_NAME = $_POST["txtApellido"];
        $EMAIL = $_POST["txtCorreo"];
        $PHONE = $_POST["txtTelefono"];
        $PASSWORD = $_POST["txtContrasenna"];

        $respuesta = RegistrarUsuario($NAME, $LAST_NAME, $EMAIL, $PHONE, $PASSWORD);
        if($respuesta == true)
        {
            header("location: ../Views/login.html");
        }
    }

    if(isset($_POST["btnInicio"]))
    {
        try{
    
            $Correo = $_POST["txtCorreo"];
            $Contrasenna = $_POST["txtContrasenna"];
  
            $respuesta = ValidarSesion($Correo, $Contrasenna);

            if($respuesta)
            {
                header("location: ../Views/home.php");
            }
            else
            {   
                $_POST["MsjPantalla"] = "Credenciales invalidas";
            }
            
        }
        catch(Exception $error)
        {
            $_POST["MsjPantalla"] = $error;// Maneja la excepción según sea necesario
        }
    }

    function ConsultarUsuario()
    {
        return ConsultaUsuario($_SESSION["IdUsuario"]);
    }

    if(isset($_POST["btnActualizar"]))
    {
        try{
            $Nombre = $_POST["txtNombre"];
            $Apellido = $_POST["txtApellido"];
            $Telefono = $_POST["txtTelefono"];
            $Email = $_POST["txtEmail"];
  
            $respuesta = ActualizarUsuario($_SESSION["IdUsuario"],$Nombre, $Apellido, $Telefono,$Email);

            if($respuesta)
            {
                $_SESSION["NombreUsuario"] = $Nombre . ' ' .  $Apellido;  
                $_POST["MsjPantalla"] = "Se ha actualizado el perfil del usuario";
            }
            else
            {   
                $_POST["MsjPantalla"] = "Ocurrio un error al actualizar el perfil de usuario";
            }
            
        }
        catch(Exception $error)
        {
            echo 'error';
            $_POST["MsjPantalla"] = $error;// Maneja la excepción según sea necesario
        }
    }