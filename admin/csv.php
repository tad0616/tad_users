<?php
include "../../../include/cp_header.php";

$file_path = XOOPS_ROOT_PATH;
$file_name = basename($_GET['f']);

$file = $file_path . "/uploads/" . $file_name;

header('Last-Modified: ' . gmdate('D, d M Y H:i:s', filemtime($file)) . ' GMT');
header('Content-Type: application/octet-stream');
header('Content-Length: ' . filesize($file));
header("Content-Disposition: attachment; filename=\"帳號列表_" . date("YmdHis") . ".csv\"");
$fp = fopen($file, 'rb');
while (!feof($fp)) {
    echo fread($fp, 1024);
}
fclose($fp);
