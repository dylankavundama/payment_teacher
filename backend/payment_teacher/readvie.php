<?php
include "connect.php";
$request="SELECT sr.id,sr.nom as idensi,sr.montant,enseignant.nom as name,sr.dateP from enseignant
inner join salaire as sr
WHERE sr.nom=enseignant.id";

$Exec=mysqli_query($connect,$request);
$result=array();

while($fectdata=$Exec->fetch_assoc()){
    $result[]=$fectdata;
}
echo json_encode($result)
?>