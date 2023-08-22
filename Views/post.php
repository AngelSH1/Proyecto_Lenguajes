<?php
include_once("../Controllers/controlblog.php");
include_once "layout.php";
?>


<!DOCTYPE html>
<html>
<head>
  <title>Crear un nuevo post</title>
  <link rel="stylesheet" href="http://localhost/Proyecto_Lenguajes/Views/Assets/css/post.css">
  <?php MostrarHead(); ?>
</head>
<body>
<?php 
        MostrarHeader();
    ?>
  <div class="admin-wrapper">
    <!-- izquierda-->
    <div class="left-sidebar">
        <ul>
            <li><a href="../Views/blog.php">Ver Blog</a></li>
            <li><a href="../Views/adminblog.php">Administrar Blog</a></li>
            <li><a href="../Views/destinos.php">Ver Destinos</a></li>
            <li><a href="../Views/admindestinos.php">Administrar Destinos</a></li>
        </ul>
    </div>
  
  <!-- derecha-->
  <div class="admin-content">
    <div class= "content">
        <div class="post-form-container"></div>
        <h1>Crear nuevo post</h1>
        <form action="prueba.php" method="post">
          <label for="titulo">Título:</label>
          <input type="text" id="titulo" name="titulo" placeholder="Ingrese el título del post" required> <br>

          <label for="mensaje">Mensaje:</label>
          <textarea id="mensaje" name="mensaje" placeholder="Ingrese el mensaje del post" required></textarea><br>

          <label for="imagen">Imagen:</label>
          <label for="imagen" class="custom-file-upload my-custom-class">Seleccionar imagen</label><br>
          <input type="file" id="imagen" name="imagen">


          <label for="lugar">Destino:</label>
          <input type="text" id="lugar" name="lugar" placeholder="Ingrese el lugar" required><br>

          <input type="submit" id="btnpublicar" name="btnpublicar" value="Guardar"><br>
          <input type="hidden" name="m" value="guardar">
        </form>
      </div>
    </div>
  </div>
  <footer>
    <?php
    MostrarFooter();

    ?>
      </footer>
  </body>
</html>
