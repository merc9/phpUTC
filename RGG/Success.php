<?php
session_start();

if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] == false) {

    header("Location: index.php");
}
?>

<h2 align='center'>You've logged in</h2>
<td>&nbsp</td>
<td><input id = "boton" type = "submit" name = "boton" value = "Log Out" onclick="window.location.href = 'http://localhost/SessionsAndCookies/Form.html';"></td> 

<div id="contenedor">

    <form action="Data.php" method="post">
        <table align="center" width="400" cellspacing="0" cellpadding="0">
            <tr>
                <td>Nombre:</td>
                <td><input type="text" name="name" placeholder="Escriba su nombre"></td>           
            </tr>
            <tr>
                <td>Apellidos</td>
                <td><input type="text" name="last_names" placeholder="Apellidos"></td>           
            </tr>
            <tr>
                <td>Tipo de identidad</td>
                <td><input type="text" list="identities" name="kind_identity"></td>
            <datalist id=identities >
                <option> Pasaporte</option>
                <option> Cédula Jurídica</option>
                <option>Cédula Identidad</option>
                <option>Cédula Residencia</option>
            </datalist>         
            </tr>
            <tr>
                <td>Número de identidad</td>
                <td><input type="text" name="number_identity"></td>             
            </tr>
            <tr>
                <td>Edad</td>
                <td><input type="text" name="age"></td>             
            </tr>
            <tr>
                <td>Fecha de nacimiento</td>
                <td><input type="date" name="birthday"></td>             
            </tr>
            <tr>    
                <td>Género</td>         
            </tr>  
            <tr>
                <td><input type="radio" name="gender" value="Hombre" checked> Hombre</td>
                <td><input type="radio" name="gender" value="Mujer"> Mujer</td>
                <td><input type="radio" name="gender" value="Otro"> Otro</td>       
            </tr>  
            <tr>
                <td>Provincia</td>
                <td><input type="text" list="provinces" name="List_Provinces"></td>
            <datalist id=provinces >
                <option> Alajuela</option>
                <option> San José</option>
                <option>Puntarenas</option>
                <option>Guanacaste</option>
                <option>Limón</option>
                <option>Heredia</option>
                <option>Cartago</option>
            </datalist>         
            </tr>

            <td>&nbsp</td>
            </br>
            <td><input id="boton" type="submit" name="boton" value="Enviar datos"></td>           
            </tr>
        </table>
    </form>
</div>
</div>