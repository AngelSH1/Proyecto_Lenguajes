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