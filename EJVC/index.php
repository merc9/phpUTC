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
        <style tex />
    </head>
    <body>
        <div class="main">
            <form action="login.php" method="post">
                <table  border="0" cellspacing="1" cellpadding="1">
                    <tr>
                        <td>Email:</td>
                        <td><input type="text" name="username" ></td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="password" ></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name="su" >Superusuario?</td>
                    </tr>
                </table>
                <input type="submit" value="Go" name="button" />
            </form>
        </div>
    </body>
</html>
