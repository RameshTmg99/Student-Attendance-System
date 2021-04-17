<?php

	header("Content-type:application/json");
	require('connectAPI.php');
	
	if(isset($_POST['username'])){

		$username = $_POST['username'];

		$query = "SELECT sub.subname FROM subjectinfo sub JOIN studentinfo stu WHERE sub.classid = stu.classid AND stu.username = ? ";
					 
		$studentq =  $conn->prepare($query);
		$studentq->bind_param("s", $username);
		$studentq->execute();
		$result = $studentq->get_result();

        $output = array();
        $output["result"]=array();

        while ($row = $result->fetch_assoc()){
            $response = array(
                "subject" => $row['subname']               
            );

            array_push($output["result"], $response);
        }

        http_response_code(200);
        
        print(json_encode($output)); 
        die();
	}
	
	else{
		$output[] = array(
			'response' => false,
		);
		print(json_encode($output)); 
		die();
	}
?>
