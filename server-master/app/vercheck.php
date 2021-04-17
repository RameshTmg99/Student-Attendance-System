<?php 
if($_POST['username']=="Jagga"){
$arr = array('version'=>"1.1",'url'=>"http://localhost/student/sas.apk");
            echo json_encode($arr);
            die();
}
?>