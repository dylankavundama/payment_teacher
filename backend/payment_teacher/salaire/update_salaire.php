<?php
include "connect.php";


    $id = $_POST['id']; 
    $nom=$_POST['nom'];
    $montant=$_POST['montant'];


    $dateP=$_POST['dateP'];



// Assuming you have an 'id' parameter for identifying the record to update




$sql = "UPDATE salaire SET `nom`=?, `montant`=?, `dateP`=? WHERE id=?";
$stmt = $connect->prepare($sql);
$stmt->bind_param("sssi", $nom, $montant, $dateP, $id);
$arra=[];
$stmt->execute();

if ($stmt->error) {
    
    $arra["success"]="false";
} else {
    echo "Update successful";
    $arra["success"]="true";
}
print(json_encode($arra));
$stmt->close();
$connect->close();
?>
