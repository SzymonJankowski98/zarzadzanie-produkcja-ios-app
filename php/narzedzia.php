<?php

$con=mysqli_connect("localhost","root","","apk");
mysqli_set_charset($con,"utf8");
if(mysqli_connect_errno())
{
    echo "blad";
}

$sql= "SELECT * FROM `maszyny_narzedzia` right JOIN narzedzia on narzedzia.ID_narzedzia = maszyny_narzedzia.ID_narzedzia GROUP BY narzedzia.nazwa ASC";

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