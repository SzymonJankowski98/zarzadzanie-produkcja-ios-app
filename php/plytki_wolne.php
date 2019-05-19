<?php

$con=mysqli_connect("localhost","root","","apk");
mysqli_set_charset($con,"utf8");
if(mysqli_connect_errno())
{
    echo "blad";
}

$sql= "SELECT * FROM `plytki` WHERE ID_plytki NOT in (SELECT ID_plytki FROM narzedzia WHERE ID_plytki is not NULL);";

if ($wynik=mysqli_query($con,$sql))
{
    $tab_wynik= array();
    $temp= array();
    
    while($wiersz = $wynik->fetch_object())
    {
        $temp=$wiersz;
        array_push($tab_wynik,$temp);
    }
    echo json_encode($tab_wynik);
}

mysqli_close($con);
?>