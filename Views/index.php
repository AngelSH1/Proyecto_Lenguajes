<?php 
    include_once "../Controllers/usuarioController.php";
    include_once "layout_login.php";
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Login</title>
    <?php MostrarHead(); ?>
    <link rel="stylesheet" href="../Views/Assets/css/login.css" />
</head>

<body>
    <?php 
        MostrarHeader();
    ?>
    <?php
                        if(isset($_POST["MsjPantalla"]))
                        {
                        echo '<div style="text-align:center;color:red" class="alert alert-light" role="alert">' . $_POST["MsjPantalla"] . '</div>';
                        }
                    ?>
    <form role="form" class="text-start" action="" method="post">
        <h1 class="title">Login</h1>
        <div class="imgcontainer">
            <img src="../Views/Assets/imgs/img_avatar2.webp" alt="Avatar" class="avatar">
        </div>

        <div class="container">
            <i class="fa fa-user"></i>
            <input id="txtCorreo" name="txtCorreo" type="email" class="form-control form-control-lg"
                placeholder="Correo Electrónico" />
        </div>

        <div class="container">
            <i class="fa fa-lock"></i>
            <input id="txtContrasenna" name="txtContrasenna" type="password" class="form-control form-control-lg"
                placeholder="Contraseña" />
        </div>
        <div class="pt-1 mb-4">
            <button id="btnInicio" name="btnInicio" type="submit" class="btn btn-dark btn-lg btn-block">Iniciar
                Sesión</button>
        </div>

        <p class="mt-4 text-sm text-center">
            ¿No tienes una cuenta?
            <a href="registro.php" class="text-primary text-gradient font-weight-bold">Ir al Registro</a>
        </p>
    </form>


    <footer>
        <?php
    MostrarFooter();

    ?>
    </footer>
</body>

</html>