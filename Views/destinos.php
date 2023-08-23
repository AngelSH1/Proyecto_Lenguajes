<?php
include_once("../Controllers/destinocontrol.php");
include_once "layout.php";
$pblog = new modeloControllerdestinos();
$datoblog = $pblog->destinosprincipal();
?>
<!DOCTYPE html>
<html>
<head>
<title>DESTINATIONS</title>
<?php MostrarHead(); ?>
    <link rel="stylesheet" href="http://localhost/Proyecto_Lenguajes/Views/Assets/css/adminDestino.css">
</head>
<?php 

MostrarHeader();
?>
<body class=>
    <div class="container-cover">
        <div class="container-info-cover">
            <div class="header">
                <h1>DESTINOS</h1>
            </div>
        </div>
    </div>

    <div class="grid-container">
      <?php if (!empty($pblog)): ?>
          <?php foreach ($datoblog as $entry): ?>
              <div class="grid-item">
                  <div class="entry-title"><?php echo "" . $entry['TITLE'] . "<br>";?></div>
                  <div class="entry-description"><?php echo "Descripción: " . $entry['DESCRIPTION'] . "<br>";?></div>
                  <div class="entry-startdate"><?php echo "Salida: " . $entry['START_DATE'] . "<br><br>";?></div>
                  <div class="entry-enddate"><?php echo "Llegada: " . $entry['END_DATE'] . "<br><br>";?></div>
                  <div class="entry-spaces"><?php echo "Espacios: " . $entry['SPACES'] . "<br><br>";?></div>
                  <div class="entry-guide"><?php echo "Guia: " . $entry['NOMBREGUIA'] . "<br><br>";?></div>
                  <div class="entry-price"><?php echo "Precio: " . $entry['PRICE'] . "<br><br>";?></div>
                </div>
          <?php endforeach; ?>
      <?php else: ?>
          <div class="grid-item" style="grid-column: 1 / -1;">No Hay blogs</div>
      <?php endif; ?>

    </div>
    <div class="botonNueno">
    <a class="agregar-button" href="../Views/AgregarDestino.php">Agregar Nuevo</a>
    </div>
    <footer>
    <?php
    MostrarFooter();

    ?>
      </footer>
</body>
</html>

