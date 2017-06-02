<?php

session_start();

if(!$_SESSION){
    header("location: index.php");
}

if(isset($_COOKIE['var'])){
    $var = $_COOKIE['var'];
    

}else{
    $var = "";
}

?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <p>Bienvenido <?php echo $_SESSION['username']; ?></p>
        <p><?php echo $var; ?></p>
        <a href="logout.php">Log out</a>
    </body>
</html>


<!--
if($var == 1){
        $var = "Eres superusuario";
    }else{
        $var="No tienes permisos de superusuario";
    }
-->