<?php 
    include_once "../Controllers/usuarioController.php";
    include_once "layout.php";
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
        <div class="col-md-3 border-right">
            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg">
                <span class="font-weight-bold">David</span><span class="text-black-50">david01@gmail.com</span><span> </span></div>
        </div>
        <div class="col-md-5 border-right">
            <div class="p-3 py-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Perfil</h4>
                </div>
                <div class="row mt-2">
                    <div class="col-md-6"><label class="labels">Nombre</label><input type="text" class="form-control" placeholder="Nombre completo" value=""></div>
                    <div class="col-md-6"><label class="labels">Usuario</label><input type="text" class="form-control" value="" placeholder="Usuario"></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12"><label class="labels">Numero de telefono</label><input type="text" class="form-control" placeholder="telefono" value=""></div>
                    <div class="col-md-12"><label class="labels">Direccion</label><input type="text" class="form-control" placeholder="Direccion completa" value=""></div>
                    <div class="col-md-12"><label class="labels">Email ID</label><input type="text" class="form-control" placeholder="Email" value=""></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6"><label class="labels">Pais</label><input type="text" class="form-control" placeholder="Pais" value=""></div>
                    <div class="col-md-6"><label class="labels">Estado</label><input type="text" class="form-control" value="" placeholder="Estado"></div>
                </div>
                <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="button">Guardar Perfil</button></div>
            </div>
        </div>
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