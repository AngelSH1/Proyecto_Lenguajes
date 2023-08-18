<?php 
    include_once "../Controllers/usuarioController.php";
    include_once "layout.php";
?>

<!DOCTYPE html>
<html lang="en">

    <head>
    <?php MostrarHead(); ?>
    <link rel="stylesheet" href="../Views/Assets/css/Registro.css" />
    </head>
<body>

<?php 
        MostrarHeader();
    ?>
  <div class="signupFrm">

      <form role="form" class="text-start" action="" method="post">
      <h1 class="title">Registro</h1>

      <div class="imgcontainer">
        <img src="../Views/Assets/imgs/img_avatar3.png" alt="Avatar" class="avatar">
      </div>

      <div class="form-outline mb-4">
        <input id="txtNombre" name="txtNombre" type="text" class="form-control form-control-lg" placeholder="Nombre" required/>
      </div>

      <div class="form-outline mb-4">
        <input id="txtApellido" name="txtApellido" type="text" class="form-control form-control-lg" placeholder="Apellido" required />
      </div>

      <div class="form-outline mb-4">
        <input id="txtCorreo" name="txtCorreo" type="email" class="form-control form-control-lg" placeholder="Correo Electrónico" required />
      </div>

      <div class="form-outline mb-4">
        <input id="txtTelefono" name="txtTelefono" type="text" class="form-control form-control-lg" placeholder="Teléfono" required />
      </div>

      <div class="form-outline mb-4">
        <input id="txtContrasenna" name="txtContrasenna" type="password"  class="form-control form-control-lg" placeholder="Contraseña" required/>
      </div>

      <div class="pt-1 mb-4">
        <button id="btnRegistro" name="btnRegistro" type="submit" class="btn btn-dark btn-lg btn-block">Registrarse</button>
      </div>
      
      <p class="mt-4 text-sm text-center">
        ¿Ya tienes una cuenta?
        <a href="Login.html" class="text-primary text-gradient font-weight-bold">Ir al Inicio de Sesión</a>
      </p>
    </form>
  </div>

    <footer>
    <?php
    MostrarFooter();

    ?>
      </footer>
</body>
</html>