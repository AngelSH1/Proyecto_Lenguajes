<?php 
    include_once "../Controllers/formulariocontroller.php";
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Servicios</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
    crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <link rel="stylesheet" href="../Views/Assets/css/formulario.css" />

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
          <h5>PAQUETES DE VIAJE</h5>

        </div>
        <div class="servicios">
          <h5>BLOG</h5>
        </div>
        <div class="servicios">
          <h5>BUSCADOR VUELOS</h5>
        </div>
      </div>
    </div>
  </nav>
<br>
  <div class="">
    <h2>¡Completa nuestro formulario y comienza tu próxima aventura!</h2>
    <p>En nuestra agencia de viajes, estamos emocionados por ayudarte a planificar el viaje de tus sueños. Queremos asegurarnos de que cada detalle sea perfecto y se ajuste a tus deseos y necesidades.
        Nuestro equipo de expertos en viajes está listo para brindarte un servicio personalizado y diseñar un itinerario que se adapte a tus gustos y preferencias. Ya sea que estés interesado en obtener una visa para Estados Unidos o Canadá, o si prefieres un viaje completamente personalizado, estamos aquí para hacerlo realidad.
        Completa nuestro formulario y déjanos conocer tus expectativas. Queremos escuchar tus ideas, responder a tus preguntas y brindarte la asesoría que necesitas para crear una experiencia única y memorable.
        No dejes pasar esta oportunidad. Llena el formulario y déjanos ser parte de tu próximo viaje extraordinario. ¡Estamos ansiosos por comenzar a trabajar contigo!</p> 
  </div>
  <br>

  <form action="" method="POST" class="formulario">
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required>

    <label for="nombre">ID:</label>
    <input type="text" id="ID_USER_SOLICITUD" name="ID_USER_SOLICITUD" required>
  
    <label for="correo">Correo electrónico:</label>
    <input type="email" id="correo" name="correo" required>
  
    <label for="telefono">Teléfono:</label>
    <input type="tel" id="telefono" name="telefono" required>
  
    <label for="tipo-servicio">Tipo de Servicio:</label>
    <select id="tipo-servicio" name="tipo-servicio" required>
      <option value="">Seleccione un tipo de servicio</option>
      <option value="visa-usa">Visa USA</option>
      <option value="visa-canada">Visa Canada</option>
      <option value="viaje-personalizado">Viaje Personalizado</option>
    </select>
  
    <label for="mensaje">Mensaje adicional:</label>
    <textarea id="mensaje" name="mensaje" rows="4"></textarea>
  
    <button id="btnRegistro" name="btnRegistro" type="submit">Enviar</button>
  </form>
  
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