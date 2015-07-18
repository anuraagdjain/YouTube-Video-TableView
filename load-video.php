<?php
//header('Content-Type: application/json');
    //Create Database connection
    $db = mysql_connect("localhost","username","password");
    if (!$db) {
        die('Could not connect to db: ' . mysql_error());
    }
 
    //Select the Database
    mysql_select_db(YOUR_DB_HERE,$db);
$rows = array();    
    //Replace * in the query with the column names.
    $result = mysql_query("select * from Video ORDER BY  `TABLE_NAME_HERE`.`id` DESC", $db);  
    
    //Create an array
    $json_response = array();
    
    while ($row = mysql_fetch_array($result)) {
              $rows[] = $row;
//       $json_response['data'] = $row_array;
        //push the values in the array
     //   array_push($json_response,$row_array);
}
$json_response = array('data' => $rows);
 //   }
    echo json_encode($json_response);
    
    //Close the database connection
    fclose($db);
 
?>


