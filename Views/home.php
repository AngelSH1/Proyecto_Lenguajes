<?php 
    include_once "layout.php";
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Home</title>
    <?php MostrarHead(); ?>
    <link rel="stylesheet" href="../Views/Assets/css/home.css" />
</head>

<body>
    <?php 
        MostrarHeader();
    ?>
    <div class="contenedor">
        <img class="imgcrr" src="../Views/Assets/imgs/img1.avif">

        <div class="price-overlay">
            <p class="historia">
                Hola mucho gusto somos Monica y Nelson, creadores de 11:11 La maleta de sueños
                Nuestro proyecto nace de nuestro amor por los viajes, tenemos como objetivo compartir con ustedes
                nuestra experiencia, pasión y amor para que puedan al igual que nosotros, tener experiencias de vida
                que siempre van a poder recordar, acompañanos en esta gran aventura, y juntos descubriremos esos
                increibles lugares
                que esconde nuestro planeta.</p>
        </div>
    </div>
    <footer>
        <?php
    MostrarFooter();

    ?>
    </footer>
</body>

</html>