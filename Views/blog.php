<?php
include_once("../Controllers/controlblog.php");
include_once("../Models/index.php");

$pblog = new modeloControllerblog();
$datoblog = $pblog->blogprincipal();

//foreach ($datoblog as $entry) {
   //echo "Título: " . $entry['TITLE'] . "<br>";
    //echo "Descripción: " . $entry['DESCRIPTION']->load() . "<br>";
    //echo "Destino: " . $entry['DESTINATION_TITLE'] . "<br><br>";
//}
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BLOG 11.11lamaletadesueño</title>
    <script src="https://kit.fontawesome.com/41bcea2ae3.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../Views/Assets/css/estilos.css">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
      crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="../Views/Assets/css/servicios.css" />
  
</head>
<body>

    <!--Header - menu-->
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
                  <a class="nav-link Dropdown" aria-current="page" href="../Views/home.html">
                  <h5>PAQUETES DE VIAJE</h5>
                </a>
                </div>
                <div class="servicios">
                  <h5>BLOG</h5>
                </div>
                <div class="servicios">   
                  <a class="nav-link Dropdown" aria-current="page" href="../Views/Buscador.html">
                  <h5>BUSCADOR VUELOS</h5>
                </a>
                </div>
              </div>
            </div>
          </nav>
    

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
                  <div class="entry-title"><?php echo "Título: " . $entry['TITLE'] . "<br>";?></div>
                  <div class="entry-description"><?php echo "Descripción: " . $entry['DESCRIPTION']->load() . "<br>";?></div>
                  <div class="entry-destination"><?php echo "Destino: " . $entry['DESTINATION_TITLE'] . "<br><br>";?></div>
              </div>
          <?php endforeach; ?>
      <?php else: ?>
          <div class="grid-item" style="grid-column: 1 / -1;">No blogs found</div>
      <?php endif; ?>
    </div>

    <div class="container-footer">	

        <footer>
            <div class="logo-footer">
                <img src="/Assets/imgs/logo.png" alt="">
            </div>

            <div class="redes-footer">
                <a href="#"><i class="fab fa-facebook-f icon-redes-footer"></i></a>
                <a href="#"><i class="fab fa-google-plus-g icon-redes-footer"></i></a>
                <a href="#"><i class="fab fa-instagram icon-redes-footer"></i></a>
            </div>

        
            

        </footer>

    </div>

</div>

    <script src="js/script.js"></script>
</body>
</html>