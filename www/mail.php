<?php
  function generateMessageID() {
    return sprintf(
      "<%s.%s@%s>",
      base_convert(microtime(), 10, 36),
      base_convert(bin2hex(openssl_random_pseudo_bytes(8)), 16, 36),
      $_SERVER['SERVER_NAME']
    );
  }

	$data['error'] = false;

	$name = $_POST['name'];
	$email = $_POST['email'];
	$subject = $_POST['subject'];
	$message = $_POST['message'];

	$formcontent="From: $name\nSubjet: $subject\nEmail: $email\nMessage: $message";

	$recipient = "target@example.com";
	$mailheader = "From: contact@example.com \r\n" .
  "Message-ID: " . generateMessageID() . "\r\n";

	if( mail($recipient, $name, $formcontent, $mailheader) == false ){
		$data['error'] = 'Error';
	}else{
		$data['error'] = false;
	}

	echo json_encode($data);
?>
