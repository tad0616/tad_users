<?php
$modversion = array();

//---模組基本資訊---//
$modversion['name'] = _MI_TADUSERS_NAME;
// $modversion['version'] = 1.8;
$modversion['version'] = $_SESSION['xoops_version'] >= 20511 ? '2.0.0-Stable' : '2.0';
$modversion['description'] = _MI_TADUSERS_DESC;
$modversion['author'] = _MI_TADUSERS_AUTHOR;
$modversion['credits'] = _MI_TADUSERS_CREDITS;
$modversion['help'] = 'page=help';
$modversion['license'] = 'GNU GPL 2.0';
$modversion['license_url'] = 'www.gnu.org/licenses/gpl-2.0.html/';
$modversion['image'] = "images/logo.png";
$modversion['dirname'] = basename(dirname(__FILE__));

//---模組狀態資訊---//
$modversion['release_date'] = '2024-12-12';
$modversion['module_website_url'] = 'https://tad0616.net/';
$modversion['module_website_name'] = _MI_TAD_WEB;
$modversion['module_status'] = 'release';
$modversion['author_website_url'] = 'https://tad0616.net/';
$modversion['author_website_name'] = _MI_TAD_WEB;
$modversion['min_php'] = 5.4;
$modversion['min_xoops'] = '2.5.10';

//---paypal資訊---//
$modversion['paypal'] = [
    'business' => 'tad0616@gmail.com',
    'item_name' => 'Donation : ' . _MI_TAD_WEB,
    'amount' => 0,
    'currency_code' => 'USD',
];

//---啟動後台管理界面選單---//
$modversion['system_menu'] = 1;

//---管理介面設定---//
$modversion['hasAdmin'] = 1;
$modversion['adminindex'] = "admin/index.php";
$modversion['adminmenu'] = "admin/menu.php";

//---使用者主選單設定---//
$modversion['hasMain'] = 0;

//---樣板設定---//
$modversion['templates'] = [
    ['file' => 'tad_users_admin.tpl', 'description' => 'tad_users_admin.tpl'],
    ['file' => 'tad_users_index.tpl', 'description' => 'tad_users_index.tpl'],
];
