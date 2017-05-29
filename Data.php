<?php
$Name = $_POST["name"];
$LastNames = $_POST["last_names"];
$Identities = $_POST["kind_identity"];
$Number_Identity = $_POST["number_identity"];
$Age = $_POST ["age"];
$Birthday = $_POST ["birthday"];
$Gender = $_POST ["gender"];
$List_provinces = $_POST ["List_Provinces"];


if (($Name == null) || ($LastNames == null) || ($Identities == null) || ($Number_Identity == null) || ($Age == null) || ($Birthday == null) || ($Gender == null) || ($List_provinces == null)) {

    echo "Favor de llenar todos los datos correspondientes";
} else {

    echo "Nombre: $Name </br> Apellidos: $LastNames </br> Tipo de identidad: $Identities </br> "
    . "Edad: $Age </br> Fecha de Nacimiento: $Birthday </br> Género: $Gender </br> Provincia: $List_provinces";
}

//**********************************************************************************************************************
?>


<td>&nbsp</td>
</br>
<td><input id="boton" type="submit" name="boton" value="Go to back" onclick="window.location.href = 'http://localhost/SessionsAndCookies/Success.php'"></td>           


