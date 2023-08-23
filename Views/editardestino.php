<?php
include_once("../Controllers/destinocontrol.php");
include_once "layout.php";

if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $pblog = new modeloControllerdestinos();
    $post = $pblog->obtenerdestinoPorID($id); // Agrega un método para obtener el post por su ID
}

?>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Post</title>
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
        <li><a href="../Views/adminDestinos.php">Administrar Destinos</a></li>
        </ul>
    </div>

    <!-- derecha-->
    <div class="admin-content">
        <div class="content">
            <div class="post-form-container"></div>
            <h1>Editar Destino</h1>
            <form action="prueba.php" method="post"> <!-- Cambia la acción al script que manejará la actualización -->
                <input type="hidden" name="id" value="<?php echo $post['ID_DESTINATION']; ?>">
                <label for="ID">ID:</label>
                <input type="text" id="id" name="id" value="<?php echo $post['ID_DESTINATION']; ?>" disabled> <br>

                <label for="title">Título:</label>
                <input type="text" id="title" name="title" value="<?php echo $post['TITLE']; ?>"required><br><br>

                <label for="description">Descripción:</label>
                <textarea id="description" name="description" required><?php echo $post['DESCRIPTION']->load(); ?></textarea><br><br>

                <label for="start_date">Fecha de inicio:</label>
                <input type="date" id="start_date" name="start_date" value="<?php echo date('Y-m-d', strtotime($post['START_DATE'])); ?>" required><br><br>

                <label for="end_date">Fecha de fin:</label>
                <input type="date" id="end_date" name="end_date" value="<?php echo date('Y-m-d', strtotime($post['END_DATE'])); ?>" required><br><br>

                <label for="spaces">Espacios:</label>
                <input type="text" id="spaces" name="spaces" value="<?php echo $post['SPACES']; ?>"required><br><br>


                <label for="guide">Guía:</label>
                <input type="text" id="guide" name="guide" value="<?php echo $post['GUIDE']; ?>"required><br><br>
                <br><br>

                <label for="price">Precio:</label>
                <input type="text" id="price" name="price" value="<?php echo $post['PRICE']; ?>"required><br><br>

                <input type="submit" id="btnactualizardestino" name="btnactualizardestino" value="Actualizar"><br>
                <input type="hidden" name="n" value="actualizar">
            </form>
        </div>
    </div>
</div>
</body>
</html>
