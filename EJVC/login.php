<?php

$username = $_POST['username'];
$password = $_POST['password'];
$superUser = $_POST['su'];
const USR = "user";
const PASS = "1234";

if ($superUser == "on"){
    $superUser = "Eres Super Usuario";
}else{
    $superUser = "No eres Super Usuario";
}

if (isset($username)) {
    session_start();
    
    if ($username == USR && $password == PASS) {
        setcookie('var',$superUser,time()+20);
        $_SESSION['username'] = $username;
        $_SESSION['password'] = $password;
        header("location: user.php");
    } else {
        header("location: index.php");
    }
}else{
    header("location: index.php");
}

?>