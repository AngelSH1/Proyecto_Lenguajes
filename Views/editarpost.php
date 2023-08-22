<?php
include_once("../Controllers/controlblog.php");
include_once "layout.php";

if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $pblog = new modeloControllerblog();
    $post = $pblog->obtenerPostPorID($id); // Agrega un método para obtener el post por su ID
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
            <li><a href="../Views/adminblog.php">Administrar Post</a></li>
        </ul>
    </div>

    <!-- derecha-->
    <div class="admin-content">
        <div class="content">
            <div class="post-form-container"></div>
            <h1>Editar Post</h1>
            <form action="prueba.php" method="post"> <!-- Cambia la acción al script que manejará la actualización -->
                <input type="hidden" name="id" value="<?php echo $post['ID_BLOG']; ?>">
                <label for="ID">ID:</label>
                <input type="text" id="id" name="id" value="<?php echo $post['ID_BLOG']; ?>" disabled> <br>

                
                <label for="titulo">Título:</label>
                <input type="text" id="titulo" name="titulo" value="<?php echo $post['TITLE']; ?>" required> <br>

                <label for="mensaje">Mensaje:</label>
                <textarea id="mensaje" name="mensaje" required><?php echo $post['DESCRIPTION']->load(); ?></textarea><br>
                
                <label for="Destino">Destino:</label>
                <input type="text" id="Destino" name="Destino" value="<?php echo $post['ID_DESTINATION']; ?>" required> <br>

                <input type="submit" id="btnactualizar" name="btnactualizar" value="Actualizar"><br>
                <input type="hidden" name="m" value="actualizar">
            </form>
        </div>
    </div>
</div>
</body>
</html>
