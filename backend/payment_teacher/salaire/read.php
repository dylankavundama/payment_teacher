<?php
include "connect.php";
$request="SELECT * FROM salaire";

$Exec=mysqli_query($connect,$request);
$result=array();

while($fectdata=$Exec->fetch_assoc()){
    $result[]=$fectdata;
}
echo json_encode($result)
?>