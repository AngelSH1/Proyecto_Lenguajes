<!DOCTYPE html>
<html>
<head>
    <title>Destinations</title>
</head>
<body>
    <h1>Destinations</h1>
    <ul>
    <?php foreach ($destinations as $destination): ?>
        <li>
            <h2><?php echo $destination['TITLE']; ?></h2>
            <p><?php echo $destination['DESCRIPTION']; ?></p>
            <p>Price: <?php echo $destination['PRICE']; ?></p>
        </li>
    <?php endforeach; ?>
    </ul>
</body>
</html>