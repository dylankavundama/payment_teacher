<?php
include "connect.php";

if(isset($_POST['id'])){
    $idToDelete = $_POST['id'];
}
else return;
 // Assuming you have an 'id' parameter for identifying the record to delete

$sql = "DELETE FROM salaire WHERE `id`=?";
$stmt = $connect->prepare($sql);
$stmt->bind_param("i", $idToDelete);

$stmt->execute();
$arr=[];

if ($stmt->error) {
    //echo "Error: " . $stmt->error;
    $arr["Success"]="False";
} else {
    //echo "Deletion successful";
    $arr["Success"]="True";
}
print(json_encode($arr));
$stmt->close();
$connect->close();
?>
