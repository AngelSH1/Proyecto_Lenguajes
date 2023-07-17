<DOCTYPE HTML>
<meta charset = "utf8" />
<?php
    function OpenBD()
    {
        return $conexion = oci_connect("ADMIN", "ADMIN", "localhost/orcl"); 
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
