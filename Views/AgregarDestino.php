<?php
include_once("../Controllers/destinocontrol.php");
include_once "layout.php";
?>
<!DOCTYPE html>
<html>
<head>
<title>Agregar Nuevo Destino</title>
<?php MostrarHead(); ?>
    
    <link rel="stylesheet" href="http://localhost/Proyecto_Lenguajes/Views/Assets/css/agregarDestino.css">
    <link rel="stylesheet" href="http://localhost/Proyecto_Lenguajes/Views/Assets/css/post.css">
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
        <h1>Agregar Nuevo Destino</h1>
        <form action="prueba.php" method="post">
          <label for="title">Título:</label>
          <input type="text" id="title" name="title" required><br><br>

          <label for="description">Descripción:</label>
          <textarea id="description" name="description" required></textarea><br><br>

          <label for="start_date">Fecha de inicio:</label>
          <input type="date" id="start_date" name="start_date" required><br><br>

          <label for="end_date">Fecha de fin:</label>
          <input type="date" id="end_date" name="end_date" required><br><br>

          <label for="spaces">Espacios:</label>
          <input type="text" id="spaces" name="spaces" required><br><br>
          
          <label for="guide">Guía:</label>
          <input type="text" id="guide" name="guide" required><br><br>

          <label for="price">Precio:</label>
          <input type="text" id="price" name="price" required><br><br>

          <div class="button-container">
              <input type="submit" id="btnpublicardestino" name="btnpublicardestino" value="Guardar"><br>
              <input type="hidden" name="n" value="guardarDestino">
          </div>
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
