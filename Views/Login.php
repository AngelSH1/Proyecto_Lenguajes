<?php 
    include_once "../Controllers/usuarioController.php";
    include_once "layout.php";
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <?php MostrarHead(); ?>
    <link rel="stylesheet" href="../Views/Assets/css/login.css" />
    </head>
<body>
<?php 
        MostrarHeader();
    ?>
    <form action="action_page.php" method="post">
      <h1 class="title">Login</h1>
        <div class="imgcontainer">
          <img src="../Views/Assets/imgs/img_avatar2.webp" alt="Avatar" class="avatar">
        </div>
      
        <div class="container">
          <i class="fa fa-user"></i>
          <label for="uname"><b>Usuario</b></label>
          <input type="text" placeholder="Ingresar Usuario" name="uname" required>
      
          <i class="fa fa-lock"></i>
          <label for="psw"><b>Contraseña</b></label>
          <input type="password" placeholder="Ingresar Contraseña" name="psw" required>
      
          <button type="submit">Login</button>
          <label>
            <input type="checkbox" checked="checked" name="remember"> Recuerdame
          </label>
        </div>
      
        <p class="mt-4 text-sm text-center">
          ¿No tienes una cuenta?
          <a href="Registro.html" class="text-primary text-gradient font-weight-bold">Ir al Registro</a>
        </p>
      </form>


    <footer>
    <?php
    MostrarFooter();

    ?>
      </footer>
</body>
</html>