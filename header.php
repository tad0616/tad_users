<?php
include_once "../../mainfile.php";
include_once 'preloads/autoloader.php';
include_once "function.php";

//判斷是否對該模組有管理權限
if (!isset($_SESSION['sys_adm'])) {
    $_SESSION['sys_adm'] = ($xoopsUser) ? $xoopsUser->isAdmin() : false;
}
