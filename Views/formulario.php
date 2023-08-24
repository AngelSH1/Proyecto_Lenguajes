<?php 
    include_once "../Controllers/formulariocontroller.php";
    include_once "layout.php";
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Formulario</title>
    <?php MostrarHead(); ?>
  <link rel="stylesheet" href="../Views/Assets/css/formulario.css" />
 </head>

<body>
<?php 
        MostrarHeader();
    ?>
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
  <?php
    MostrarFooter();

    ?>
  </footer>

</body>

</html>