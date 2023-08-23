<?php
include_once("../Controllers/destinocontrol.php");
include_once "layout.php";
$pblog = new modeloControllerdestinos();
$datoblog = $pblog->destinos();
?>
<!DOCTYPE html>
<html>
<head>
<title>Administracion De Destinos</title>
<?php MostrarHead(); ?>
<link rel="stylesheet" href="http://localhost:/Proyecto_Lenguajes/Views/Assets/css/adminblog.css">
<link rel="stylesheet" href="http://localhost:85/Proyecto_Lenguajes/Views/Assets/css/adminblog.css">
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
                <li><a href="../Views/AgregarDestino.php">Crear Destino</a></li>

            </ul>
        </div>
        <!-- derecha-->
        <div class="admin-content">
             <div class= "content">
                <h2 class="page-title">Administracion de Destinos</h2>
                <table>
                    <thead>
                        <th>ID</th>
                        <th>Destino</th>
                        <th>Espacios</th>
                        <th colspan="2">Accion</th>
                    </thead>
                    <tbody>
                    <?php foreach ($datoblog as $key => $value) : ?>
                        <tr>
                            <td><?php echo $value['ID_DESTINATION']; ?></td>
                            <td><?php echo $value['TITLE']; ?></td>
                            <td><?php echo $value['SPACES']; ?></td>
                            <td>
                                <a class="edit" href="editardestino.php?id=editar&id=<?php echo $value['ID_DESTINATION']; ?>">EDITAR</a>
                                <a class="delete" href="prueba.php?n=eliminarDestino&id=<?php echo $value['ID_DESTINATION']; ?>">ELIMINAR</a>
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