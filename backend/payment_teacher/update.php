<?php
include "connect.php";


    $id = $_POST['id']; 
    $nom=$_POST['nom'];
    $matricule=$_POST['matricule'];


    $dateN=$_POST['dateN'];



// Assuming you have an 'id' parameter for identifying the record to update




$sql = "UPDATE enseignant SET `nom`=?, `matricule`=?, `dateN`=? WHERE id=?";
$stmt = $connect->prepare($sql);
$stmt->bind_param("sssi", $nom, $matricule, $dateN, $id);
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
