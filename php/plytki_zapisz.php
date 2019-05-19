<?php

$con=mysqli_connect("localhost","root","","apk");
mysqli_set_charset($con,"utf8");
if(mysqli_connect_errno())
{
    echo "blad";
}

$zapytanie = $_POST['a'];
$ilosc_ostrzy = $_POST['b'];

if($con)
{
    $zapytanie2 = "SELECT ID_plytki FROM plytki GROUP by ID_plytki DESC LIMIT 1";
    mysqli_query($con, $zapytanie);
    $wynik = mysqli_query($con, $zapytanie2);
    $id = mysqli_fetch_array($wynik);
    for($i=1; $i<=$ilosc_ostrzy;$i++)
    {
        $zapytanie3 = "INSERT INTO `apk`.`plytki_ostrza` (`ID`,`ID_plytki`,`Ilosc_sztuk`,`Nr_ostrza`,`zuzycie`) VALUES (NULL,'".$id["ID_plytki"]."', '0','".$i."',FALSE);";
        mysqli_query($con, $zapytanie3);
        print($i);
    }
}
mysqli_close($con);
?>