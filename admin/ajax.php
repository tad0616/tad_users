<?php
use Xmf\Request;
use XoopsModules\Tadtools\Utility;

include_once "header.php";

$op = Request::getString('op');
$name = Request::getString('name');
$value = Request::getString('value');
$pk = Request::getInt('pk');
$uid = Request::getInt('uid');

switch ($op) {
    case "update_value":
        echo update_value($name, $value, $uid);
        break;

}

// include_once 'footer.php';

function update_value($name, $value, $uid)
{
    global $xoopsDB;

    $sql = "update " . $xoopsDB->prefix("users") . " set `{$name}`='{$value}' where uid='$uid'";
    $xoopsDB->queryF($sql) or Utility::web_error($sql, __FILE__, __LINE__);
    return $value;

}
