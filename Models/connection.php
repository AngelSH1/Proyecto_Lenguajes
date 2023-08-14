<DOCTYPE HTML>
<meta charset = "utf-8" />
<?php
    function OpenBD()
    {
        return $conexion = oci_connect("ADMIN", "ADMIN", "localhost/orcl", "AL32UTF8");
    }

    function CloseBD($enlace)
    {
        if (!$enlace) {    
            $m = oci_error();    
            echo $m['message'], "n";    
            exit; 
        }
        
    }

?>
