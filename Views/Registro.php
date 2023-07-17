<?php 
    include_once "../Controllers/usuarioController.php";
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Registro</title>
        <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        />
        <link rel="stylesheet" href="../Views/Assets/css/Registro.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
    crossorigin="anonymous"></script>
    
    </head>
<body>
  <nav>
    <div class="nav-container">
      <div class="main-info-container">
        <img class="logo-img" src="../Views/Assets/imgs/logo.png" alt="" />
      </div>
      <div class="data-container">
        <div class="servicios">
          <a class="nav-link Dropdown" aria-current="page" href="../Views/servicios.html">
            <h5>SERVICIOS</h5>
          </a>
        </div>
        <div class="servicios">
          <a class="nav-link Dropdown" aria-current="page" href="../Views/Login.html">
            <h5>PAQUETES DE VIAJE</h5>
          </a>
        </div>
        <div class="servicios">          
          <a class="nav-link Dropdown" aria-current="page" href="../Views/Login.html">
            <h5>BLOG</h5>
          </a>
        </div>
        <div class="servicios">          
          <a class="nav-link Dropdown" aria-current="page" href="../Views/Login.html">
            <h5>BUSCADOR VUELOS</h5>
          </a>
        </div>
      </div>
    </div>
  </nav>
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
        <script src="../Views/Assets/js/home.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <div class="socials">
          <i class="fa-brands fa-instagram fa-2x"></i>
          <i class="fa-brands fa-whatsapp fa-2x"></i>
          <i class="fa-regular fa-envelope fa-2x"></i>
        </div>
        <p class="copy">Derechos reservados joshua33657@gmail.com 2023</p>
      </footer>
</body>
</html>