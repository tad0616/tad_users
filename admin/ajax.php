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

    $sql = 'UPDATE `' . $xoopsDB->prefix('users') . '` SET `' . $name . '`=? WHERE `uid`=?';
    Utility::query($sql, 'si', [$value, $uid]) or Utility::web_error($sql, __FILE__, __LINE__);

    return $value;

}
