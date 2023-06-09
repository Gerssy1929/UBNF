<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Methods: HEAD, GET, POST, PUT, PATCH, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method,Access-Control-Request-Headers, Authorization");
header('Content-Type: application/json');
$method = $_SERVER['REQUEST_METHOD'];
if ($method == "OPTIONS") {
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method,Access-Control-Request-Headers, Authorization");
header("HTTP/1.1 200 OK");
die();
}


    require "config.php";
     
         $prop=$_POST['prop'];
         $renter=$_POST['renter'];
         $name=$_POST['name'];
         $address=$_POST['address'];
         $inicDate=$_POST['inicDate'];
         $endDate=$_POST['endDate'];
         $visitors=$_POST['visitors'];
         $total=$_POST['total'];
         
         if (empty($prop) || empty($renter) || empty($name) || empty($address) || empty($inicDate) || empty($endDate) || empty($visitors) || empty($total)) {
        $error[] = array('mensaje' => 'Todos los campos deben estar llenos');
        $json_string = json_encode($error);
        echo $json_string;
        die();
    }
         
       $sql = "INSERT INTO rents (id,prop,renter,name,address,inicDate,endDate,visitors,total) VALUES (default,'$prop', '$renter', '$name', '$address', '$inicDate', '$endDate', '$visitors', '$total')";
    

    if (mysqli_query($con, $sql)) {
         $clientes[] = array('mensaje'=> "Alquiler Exitoso");
  } else {
       $clientes[] = array('mensaje'=> "No se realizó el Alquiler");
  }
     

    
   
$json_string = json_encode($clientes);
echo $json_string;
?>
