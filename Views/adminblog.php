<?php
include_once("../Controllers/controlblog.php");
include_once "layout.php";

$pblog = new modeloControllerblog();
$datoblog = $pblog->blog();

?>
<!DOCTYPE html>
<html>
<head>
<title>Administracion De Blog</title>
<?php MostrarHead(); ?>
<link rel="stylesheet" href="http://localhost:/Proyecto_Lenguajes/Views/Assets/css/adminblog.css">
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
                <li><a href="../Views/post.php">Crear Blog</a></li>
                <li><a href="../Views/destinos.php">Ver Destinos</a></li>
                <li><a href="../Views/admindestinos.php">Administrar Destinos</a></li>
                <button><span>Super Boton</span></button>
            </ul>
        </div>
        <!-- derecha-->
        <div class="admin-content">
             <div class= "content">
                <h2 class="page-title">Administracion de Blog</h2>
                <table>
                    <thead>
                        <th>ID</th>
                        <th>Titulo</th>
                        <th>Autor</th>
                        <th colspan="2">Accion</th>
                    </thead>
                    <tbody>
                    <?php foreach ($datoblog as $key => $value) : ?>
                        <tr>
                            <td><?php echo $value['ID_BLOG']; ?></td>
                            <td><?php echo $value['TITLE']; ?></td>
                            <td><?php echo $value['ID_USER']; ?></td>
                            <td>
                                <div class= "button-container">
                                    <button><span><a class="custom-button" href="editarpost.php?id=editar&id=<?php echo $value['ID_BLOG']; ?>">EDITAR</a></span></button>
                                    <button><span><a class="custom-button" href="prueba.php?m=eliminar&id=<?php echo $value['ID_BLOG']; ?>">ELIMINAR</a></span></button>
                                </div>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
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