<?php
include "connect.php";
$nom=$_POST['nom'];
$matricule=$_POST['matricule'];
$dateN=$_POST['dateN'];

$sql="INSERT INTO enseignant (`nom`, `matricule`, `dateN`) values (?,?,?)";
$stmt=$connect->prepare($sql);
$stmt->bind_param("sss",$nom,$matricule,$dateN);

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

