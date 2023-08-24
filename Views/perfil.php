<?php 
    include_once "../Controllers/usuarioController.php";
    include_once "layout.php";

    $usuario = ConsultarUsuario();
?>

<!DOCTYPE html>
<html lang="en">
    <head>
    <?php MostrarHead(); ?>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Perfil</title>
        <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        />
        <link rel="stylesheet" href="../Views/Assets/css/Perfil.css" />
    
    </head>
<body>
<?php 
        MostrarHeader();
    ?>
  <div class="container rounded bg-white mt-5 mb-5">
    <div class="row">
        <?php
            if(isset($_POST["MsjPantalla"]))
            {
                echo '<div style="text-align:center" class="alert alert-light" role="alert">' . $_POST["MsjPantalla"] . '</div>';
            }
        ?>

        <form role="form" class="text-start" action="" method="post">
            <div class="col-lg-12 text-center">
                <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg">
                    <span class="font-weight-bold"><?php echo $usuario["NAME"] . ' ' . $usuario["LAST_NAME"] ?></span><span class="text-black-50"><?php echo $usuario["EMAIL"] ?></span><span> </span></div>
            </div>
            <div class="col-lg-12 text-left">
                <div class="p-3 py-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right">Perfil</h4>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6"><label>Nombre</label><input required id="txtNombre" name="txtNombre" type="text" class="form-control" placeholder="Nombre" value="<?php echo $usuario["NAME"] ?>"></div>
                        <div class="col-md-6"><label>Apellido</label><input required id="txtApellido" name="txtApellido" type="text" class="form-control" value="<?php echo $usuario["LAST_NAME"] ?>" placeholder="Apellido"></div>                    
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12"><label>Numero de telefono</label><input required id="txtTelefono" name="txtTelefono" type="text" class="form-control" placeholder="telefono" value="<?php echo $usuario["PHONE"] ?>"></div>
                        <div class="col-md-12"><label>Email ID</label><input required id="txtEmail" name="txtEmail" type="text" class="form-control" placeholder="Email" value="<?php echo $usuario["EMAIL"] ?>"></div>
                    <div class="mt-5 text-center"><button id="btnActualizar" name="btnActualizar" type="submit" class="btn btn-info w-100 my-4 mb-2">Guardar Perfil</button></div>
                </div>
            </div>
        </form>
    </div>
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