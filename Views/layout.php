<?php
    if (session_status() === PHP_SESSION_NONE) {
      session_start();
  }

function MostrarHead()
{
    echo' <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../Views/Assets/css/usa.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
      crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    ';
}

function MostrarHeader()
{
    echo '<nav>
    <div class="nav-container">
      <div class="main-info-container">
      <a class="nav-link Dropdown" aria-current="page" href="../Views/home.php">
        <img class="logo-img" src="../Views/Assets/imgs/logo.png" alt="" />
        </a>
      </div>
      <div class="data-container">
        <div class="servicios">        
          <h5>'.$_SESSION["NombreUsuario"].'</h5>
        </div>
        <div class="servicios">
          <a class="nav-link Dropdown" aria-current="page" href="../Views/servicios.php">
            <h5>SERVICIOS</h5>
          </a>
        </div>
        <div class="servicios">
        <a class="nav-link Dropdown" aria-current="page" href="../Views/destinos.php">
          <h5>PAQUETES DE VIAJE</h5>
          </a>
        </div>
        <div class="servicios">
        <a class="nav-link Dropdown" aria-current="page" href="../Views/blog.php">
          <h5>BLOG</h5>
          </a>
        </div>
        <div class="servicios">
        <a class="nav-link Dropdown" aria-current="page" href="../Views/perfil.php">
        <h5>PERFIL</h5>
        </a>
         </div>
      </div>
    </div>
  </nav>
    <!-- Navbar End -->';
}

function MostrarFooter()
{
    echo'<script src="../Views/Assets/js/home.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <div class="socials">
      <i class="fa-brands fa-instagram fa-2x"></i>
      <i class="fa-brands fa-whatsapp fa-2x"></i>
      <i class="fa-regular fa-envelope fa-2x"></i>
    </div>
    <p class="copy">Derechos reservados lamaletadesueños@gmail.com 2023</p>';

}

?>