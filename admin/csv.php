<?php
include "../../../include/cp_header.php";

$file_name = htmlspecialchars($_GET['f']);

$file = XOOPS_ROOT_PATH . "/uploads/" . $file_name;

header('Last-Modified: ' . gmdate('D, d M Y H:i:s', filemtime($file)) . ' GMT');
header('Content-Type: application/octet-stream');
header('Content-Length: ' . filesize($file));
header("Content-Disposition: attachment; filename=\"帳號列表_" . date("YmdHis") . ".csv\"");
echo file_get_contents($file);
