<?php 
$host_name="localhost:3306";
$username="root";
$password="";
$db="payment_teacher_db";

$connect=new mysqli($host_name,$username,$password,$db);

if($connect){
    
}
else{
    echo "Connection Failed";
}
?>