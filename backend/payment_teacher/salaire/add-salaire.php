<?php
include "connect.php";
$nom=$_POST['nom'];
$montant=$_POST['montant'];
$dateP=$_POST['dateP'];

$sql="INSERT INTO salaire (`nom`, `montant`, `dateP`) values (?,?,?)";
$stmt=$connect->prepare($sql);
$stmt->bind_param("sss",$nom,$montant,$dateP);

$stmt->execute();

if ($stmt->error){
echo "Error : " .$stmt->error;
}
else{
    echo "Insertion successfully";
}
$stmt->close();
$connect->close();
?>

