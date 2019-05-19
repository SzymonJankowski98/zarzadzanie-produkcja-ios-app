<?php

$con=mysqli_connect("localhost","root","","apk");
mysqli_set_charset($con,"utf8");
if(mysqli_connect_errno())
{
    echo "blad";
}

$zapytanie = $_POST['a'];

if($con)
{
    mysqli_query($con, $zapytanie); 
}
mysqli_close($con);
?>