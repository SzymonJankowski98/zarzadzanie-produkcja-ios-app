<?php

$con=mysqli_connect("localhost","root","","apk");
mysqli_set_charset($con,"utf8");
if(mysqli_connect_errno())
{
    echo "blad";
}

$zapytanie = $_POST['a'];
$ilosc_gniazd = $_POST['b'];

if($con)
{
    $zapytanie2 = "SELECT ID_maszyny FROM maszyny GROUP by ID_maszyny DESC LIMIT 1";
    mysqli_query($con, $zapytanie);
    $wynik = mysqli_query($con, $zapytanie2);
    $id = mysqli_fetch_array($wynik);
    for($i=1; $i<=$ilosc_gniazd;$i++)
    {
        $zapytanie3 = "INSERT INTO `apk`.`maszyny_narzedzia` (`ID`,`ID_maszyny`,`ID_narzedzia`,`Nr_gniazda`) VALUES (NULL,'".$id["ID_maszyny"]."', NULL,'".$i."');";
        mysqli_query($con, $zapytanie3);
    }
}
mysqli_close($con);
?>