<?php
require_once("config.php");
require_once("Controllers/controlblog.php");

if(isset($_GET['m'])):
    
    if(method_exists("modeloControllerblog",$_GET['m'])):
        modeloControllerblog::{$_GET['m']}();
    endif;
else:    
modeloControllerblog::blog();
endif;

