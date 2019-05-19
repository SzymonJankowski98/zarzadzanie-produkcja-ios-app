<?php

$con=mysqli_connect("localhost","root","","apk");
mysqli_set_charset($con,"utf8");
if(mysqli_connect_errno())
{
    echo "blad";
}

$id = $_GET['id'];

$sql= "SELECT * FROM `plytki` JOIN `plytki_ostrza` ON `plytki_ostrza`.`ID_plytki`=`plytki`.`ID_plytki` WHERE plytki_ostrza.ID_plytki=".$id.";";

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