<!DOCTYPE html>
<html>
<head>
    <title>DESTINATIONS</title>
    <link rel="stylesheet" href="http://localhost/Proyecto_Lenguajes/Proyecto_Lenguajes/Assets/css/index.css">
</head>
<body class=>
    <h1>DESTINATIONS</h1>
    <div class="grid-container">
        <?php if (!empty($dato)): ?>
            <?php foreach ($dato[0] as $row): ?>
                <div class="grid-item">
                    <h2 class ="titulito"><?php echo isset($row['TITLE']) ? $row['TITLE'] : ''; ?></h2>
                    <p><strong>Description:</strong> <?php echo isset($row['DESCRIPTION']) ? $row['DESCRIPTION'] : ''; ?></p>
                    <p><strong>Start Date:</strong> <?php echo isset($row['START_DATE']) ? $row['START_DATE'] : ''; ?></p>
                    <p><strong>End Date:</strong> <?php echo isset($row['END_DATE']) ? $row['END_DATE'] : ''; ?></p>
                    <p><strong>Spaces:</strong> <?php echo isset($row['SPACES']) ? $row['SPACES'] : ''; ?></p>
                    <p><strong>Guide:</strong> <?php echo isset($row['GUIDE']) ? $row['GUIDE'] : ''; ?></p>
                    <p><strong>Price:</strong> <?php echo isset($row['PRICE']) ? $row['PRICE'] : ''; ?></p>
                    <button class="buy-button">Comprar</button>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <div class="grid-item" style="grid-column: 1 / -1;">No destinations found</div>
        <?php endif; ?>
    </div>
</body>
</html>
