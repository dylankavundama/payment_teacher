<?php
include "connect.php";


    $id = 14; 



    $nom='nom';


    $matricule='matricule';



    $dateN='dateN';


// Assuming you have an 'id' parameter for identifying the record to update




$sql = "UPDATE enseignant SET `nom`=?, `matricule`=?, `dateN`=? WHERE `id`=?";
$stmt = $connect->prepare($sql);
$stmt->bind_param("sssi", $nom, $matricule, $dateN, $id);

$stmt->execute();
$arra=[];
if ($stmt->error) {
    echo "Error: " . $stmt->error;
    print("ERROR");
    $arr["success"]='false';
} else {
    echo "Update successful";
    $arr['success']="true";
}
print(json_encode($arr));
$stmt->close();
$connect->close();
?>
