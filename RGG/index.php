<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        $Username = $_POST["UserName"];
        $Password = $_POST["Password"];
        $user_name = "RGG";
        $pass = "123456";

        session_start();

        /* if (isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] == true) {

          header("Location: Success.php");
          } */
        if (($Username === $user_name) && ($Password === $pass)) {
            if (isset($_POST["UserName"]) && isset($_POST["Password"])) {


                $_SESSION["loggedin"] = true;
                header("Location: Success.php");
            }
        } elseif ($Username == null && $Password == null) {

            echo "Favor de llenar los datos";
        } elseif ($Username != $user_name || $Password != $pass) {

            echo "Usuario y/o contraseña incorrecto (s) </br> Verifique la información digitada, intente de nuevo </br>";
        }
        ?>

    <td>&nbsp</td>
    <td><input id="boton" type="submit" name="boton" value="Home" onclick="window.location.href = 'http://localhost/SessionsAndCookies/Form.html';"></td> 
</body>
</html>
