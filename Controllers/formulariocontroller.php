<?php
    include_once "../Models/formulariomodel.php";

    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    
    if(isset($_POST["btnRegistro"]))
    {
        $ID_USER_SOLICITUD = $_POST["ID_USER_SOLICITUD"];
        $FULLNAME = $_POST["nombre"];
        $EMAIL = $_POST["correo"];
        $PHONE = $_POST["telefono"];
        $SERVICIO = $_POST["tipo-servicio"];
        $MENSAJE = $_POST["mensaje"];

        $respuesta = RegistrarFormulario($ID_USER_SOLICITUD, $FULLNAME, $EMAIL, $PHONE, $SERVICIO, $MENSAJE);
        if($respuesta == true)
        {
            header("location: ../Views/home.html");
        }
    }