<?php
$adminmenu = array();

$i = 1;
$adminmenu[$i]['title'] = _MI_TAD_ADMIN_HOME;
$adminmenu[$i]['link'] = 'admin/index.php';
$adminmenu[$i]['icon'] = 'images/admin/home.png';

$i++;
$adminmenu[$i]['title'] = _MI_TADUSERS_ADMENU1;
$adminmenu[$i]['link'] = "admin/main.php";
$adminmenu[$i]['icon'] = "images/admin/review.png";

$i++;
$adminmenu[$i]['title'] = _MI_TADUSERS_ADMENU2;
$adminmenu[$i]['link'] = "admin/add.php";
$adminmenu[$i]['icon'] = "images/admin/add.png";

$i++;
$adminmenu[$i]['title'] = _MI_TAD_ADMIN_ABOUT;
$adminmenu[$i]['link'] = 'admin/about.php';
$adminmenu[$i]['icon'] = 'images/admin/about.png';
