<?php
include_once("../Controllers/controlblog.php");
include_once "layout.php";
$pblog = new modeloControllerblog();
$datoblog = $pblog->blogprincipal();
?>



<!DOCTYPE html>
<html lang="en">
<head>
<title>Blog</title>
    <?php MostrarHead(); ?>
    <link rel="stylesheet" href="../Views/Assets/css/estilos.css">
</head>
<body>

<?php 

        MostrarHeader();
    ?>
    

    <!--Portada-->

    <div class="container-all" id="move-content">

    
    <div class="container-cover">
        <div class="container-info-cover">
            <h1>¡Todo es posible!</h1>
            <p>Somos una compañia familiar apasionada por los viajes</p>
        </div>
    </div>

    <div class="grid-container">
      <?php if (!empty($pblog)): ?>
          <?php foreach ($datoblog as $entry): ?>
              <div class="grid-item">
                  <div class="entry-title"><?php echo "" . $entry['TITLE'] . "<br>";?></div>
                  <div class="entry-description"><?php echo "Descripción: " . $entry['DESCRIPTION']->load() . "<br>";?></div>
                  <div class="entry-destination"><?php echo "Destino: " . $entry['DESTINATION_TITLE'] . "<br><br>";?></div>
              </div>
          <?php endforeach; ?>
      <?php else: ?>
          <div class="grid-item" style="grid-column: 1 / -1;">No Hay blogs</div>
      <?php endif; ?>
    </div>



</div>

    <script src="js/script.js"></script>
    <footer>
    <?php
    MostrarFooter();

    ?>
      </footer>
</body>
</html>