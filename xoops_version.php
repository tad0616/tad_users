<?php

$modversion = array();

//---模組基本資訊---//
$modversion['name'] = _MI_TADUSERS_NAME;
$modversion['version'] = 1.8;
$modversion['description'] = _MI_TADUSERS_DESC;
$modversion['author'] = _MI_TADUSERS_AUTHOR;
$modversion['credits'] = _MI_TADUSERS_CREDITS;
$modversion['help'] = 'page=help';
$modversion['license'] = 'GNU GPL 2.0';
$modversion['license_url'] = 'www.gnu.org/licenses/gpl-2.0.html/';
$modversion['image'] = "images/logo.png";
$modversion['dirname'] = basename(dirname(__FILE__));

//---模組狀態資訊---//
$modversion['release_date'] = '2023/08/20';
$modversion['module_website_url'] = 'https://tad0616.net/';
$modversion['module_website_name'] = _MI_TAD_WEB;
$modversion['module_status'] = 'release';
$modversion['author_website_url'] = 'https://tad0616.net/';
$modversion['author_website_name'] = _MI_TAD_WEB;
$modversion['min_php'] = 5.4;
$modversion['min_xoops'] = '2.5';

//---paypal資訊---//
$modversion['paypal'] = array();
$modversion['paypal']['business'] = 'tad0616@gmail.com';
$modversion['paypal']['item_name'] = 'Donation : ' . _MI_TAD_WEB;
$modversion['paypal']['amount'] = 0;
$modversion['paypal']['currency_code'] = 'USD';

//---啟動後台管理界面選單---//
$modversion['system_menu'] = 1;

//---管理介面設定---//
$modversion['hasAdmin'] = 1;
$modversion['adminindex'] = "admin/index.php";
$modversion['adminmenu'] = "admin/menu.php";

//---使用者主選單設定---//
$modversion['hasMain'] = 0;

//---樣板設定---//
$modversion['templates'] = array();
$i = 1;
$modversion['templates'][$i]['file'] = 'tad_users_admin.tpl';
$modversion['templates'][$i]['description'] = 'tad_users_admin.tpl';

$i++;
$modversion['templates'][$i]['file'] = 'tad_users_index.tpl';
$modversion['templates'][$i]['description'] = 'tad_users_index.tpl';
