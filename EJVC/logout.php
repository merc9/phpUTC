<?php
session_start();
if($_SESSION['username']){
    session_destroy();
    header("location: index.php");
}else{
    header("location: index.php");
}
?>
