
<!DOCTYPE html>
<html>
<head>
    <title>Agregar Nuevo Destination</title>
    <link rel="stylesheet" href="http://localhost/Proyecto_Lenguajes/Assets/css/formulario.css">
</head>
<body>
    <h1>Agregar Nuevo Destination</h1>
    <form action="" method="get" enctype="multipart/form-data">
        <label for="title">Título:</label>
        <input type="text" id="title" name="title" required><br><br>

        <label for="description">Descripción:</label>
        <textarea id="description" name="description" required></textarea><br><br>

        <label for="start_date">Fecha de inicio:</label>
        <input type="date" id="start_date" name="start_date" required><br><br>

        <label for="end_date">Fecha de fin:</label>
        <input type="date" id="end_date" name="end_date" required><br><br>

        <label for="spaces">Espacios:</label>
        <input type="number" id="spaces" name="spaces" required><br><br>


        <label for="guide">Guía:</label>
        <?php if (!empty($datosGuias[0])): ?>
            <select id="guide" name="guide" required>
                <option value="">Seleccione una opción</option>
                <?php foreach ($datosGuias[0] as $guia): ?>
                    <option value="<?php echo $guia['NAME']; ?>"><?php echo $guia['NAME']; ?></option>
                <?php endforeach; ?>
            </select>
        <?php else: ?>
            <p>No hay guías disponibles</p>
        <?php endif; ?>
        <br><br>

        <label for="price">Precio:</label>
        <input type="number" id="price" name="price" required><br><br>
        <div class="button-container">
            <button onclick="window.history.back();" type="button">Regresar</button>
            <input type="submit" value="Guardar">
        </div>
    </form>
</body>
</html>
