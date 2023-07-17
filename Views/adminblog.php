<!DOCTYPE html>
<html>
<head>
  <title>Administracion Blog</title>
  <meta charset="UTF-8">
  <script src="https://kit.fontawesome.com/41bcea2ae3.js" crossorigin="anonymous"></script>
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link rel="stylesheet" href="http://localhost:85/Proyecto_Lenguajes/Views/Assets/css/adminblog.css">
  <link rel="stylesheet" href="http://localhost:85/Proyecto_Lenguajes/Views/Assets/css/servicios.css">
  <link rel="stylesheet" href="http://localhost:/Proyecto_Lenguajes/Views/Assets/css/adminblog.css">
  <link rel="stylesheet" href="http://localhost:/Proyecto_Lenguajes/Views/Assets/css/servicios.css">


</head>
<body>
  <nav>
    <div class="nav-container">
      <div class="main-info-container">
      <img class="logo-img" src="http://localhost:85/Proyecto_Lenguajes/Views/Assets/imgs/logo.png" alt="" />
        <img class="logo-img" src="http://localhost/Proyecto_Lenguajes/Views/Assets/imgs/logo.png" alt="" />
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
            <a class="nav-link Dropdown" aria-current="page" href="../Views/blog.html">
                <h5>BLOG</h5>
              </a>
        </div>
        <div class="servicios">   
          <a class="nav-link Dropdown" aria-current="page" href="../Views/Buscador.html">
          <h5>BUSCADOR VUELOS</h5>
        </a>
        </div>
      </div>
    </div>
  </nav>
  <div class="admin-wrapper">
        <!-- izquierda-->
        <div class="left-sidebar">
            <ul>
                <li><a href="../Views/blog.html">Ver Blog</a></li>
                <li><a href="../Views/post.html">Crear Post</a></li>
            </ul>
        </div>
        <!-- derecha-->
        <div class="admin-content">
             <div class= "content">
                <h2 class="page-title">Administracion de Post</h2>
                <table>
                    <thead>
                        <th>ID</th>
                        <th>Titulo</th>
                        <th>Autor</th>
                        <th colspan="2">Accion</th>
                    </thead>
                    <tbody>
                        <?php foreach ($datoblog as $key => $value)
                            foreach($value as $v):?>
                                <tr>
                                    <td><?php echo $v['ID_BLOG']?></td>
                                    <td><?php echo $v['TITLE']?></td>
                                    <td><?php echo $v['ID_USER']?></td>
                                    <td>
                                        <a class ="edit" href="/index.php?m=editar&id=<?php echo $v['ID_BLOG']?>">EDITAR</a>
                                        <a class ="delete" href="/index.php?m=eliminar&id=<?php echo $v['ID_BLOG']?>">ELIMINAR</a>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                    </tbody>
                </table>
             </div>
        </div>

  </div>
</body>
</html>