<?php
    if(isset($_POST['add']))
    {
        $dbhost = 'www.db4free.net';
        $dbuser = 'mlhprime';
        $dbpass = 'prime2016';
        $dbname = 'mlhdada';
        $conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname); // Create connection
        if(! $conn )
        {
            die('Could not connect: ' . mysql_error());
        }
        if(! get_magic_quotes_gpc() )
        {
            $emp_name = addslashes ($_POST['emp_name']);
            $emp_address = addslashes ($_POST['emp_address']);
            $emp_address1 = addslashes ($_POST['emp_address1']);
            $emp_address2 = addslashes ($_POST['emp_address2']);
            $emp_address3 = addslashes ($_POST['emp_address3']);
            $emp_address0 = addslashes ($_POST['emp_address0']);
            $expl = addslashes ($_POST['expl']);
            $cause = addslashes ($_POST['cause']);
        }
        else
        {
            $emp_name = $_POST['emp_name'];
            $emp_address = $_POST['emp_address'];
        }
        $sql ="INSERT INTO info (first, last, adress, city, state, zip,issuesel,why)
        VALUES ('$emp_name', '$emp_address', '$emp_address0', '$emp_address1', '$emp_address2', '$emp_address3', '$expl', '$cause')";
        $retval = $conn->query($sql);
        if(! $retval )
        {
            die('Could not enter data: ' . $conn->connect_error);
        }
        header("Location: http://www.google.com");
        //echo "Entered data successfully\n";
        $conn->close();
    }
    else
    {
        ?>