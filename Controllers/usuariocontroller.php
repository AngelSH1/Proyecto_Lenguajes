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
        
            if($respuesta == 1)
            {   
                // Sesión válida, establece las variables de sesión y redirecciona
                $_SESSION["IdUsuario"] = $Correo;  // Cambia esto según tus necesidades
                $_SESSION["NombreUsuario"] = $Contrasenna;  // Cambia esto según tus necesidades
                header("location: ../Views/home.php");
            }
            else
            {   
                $_POST["MsjPantalla"] = "Credenciales invalidas";
            }
            
        }
        catch(Exception $error)
        {
            // Maneja la excepción según sea necesario
        }
    }