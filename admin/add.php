<?php

use Xmf\Request;
use XoopsModules\Tadtools\Utility;
/*-----------引入檔案區--------------*/
$xoopsOption['template_main'] = "tad_users_admin.tpl";
include_once "header.php";
include_once "../function.php";

/*-----------function區--------------*/

function add_user_form()
{
    global $xoopsTpl;
    $group_select = group_select("data[groupid]");
    $xoopsTpl->assign('group_select', $group_select);
}

//新增後的檢查動作
function check_set($data = array())
{
    global $xoopsTpl;
    $j = $data['id_start'];
    $csv = "";
    $file_name = session_id() . date("YmdHis");
    $xoopsTpl->assign('file_name', $file_name);

    $accounts = [];
    for ($i = 0; $i < $data['user_num']; $i++) {

        //帳號
        $acc['id'] = $id = $data['id_str'] . $j;

        $acc['id_existed'] = id_existed($id);

        //密碼
        if ($data['pass_mode'] == "random") {
            $n = rand(0, (32 - $data['pass_num']));
            $acc['passwd'] = substr(md5(rand(0, 1000000)), $n, $data['pass_num']);
        } elseif ($data['pass_mode'] == "same_as_id") {
            $acc['passwd'] = $id;
        } elseif ($data['pass_mode'] == "fixed") {
            $acc['passwd'] = $data['password'];
        } elseif ($data['pass_mode'] == "fixed2") {
            $acc['passwd'] = $data['password2'] . $j;
        }

        $passwd = $acc['passwd'];
        if (!$id_existed) {
            $csv .= "{$id},{$passwd}\n";
        }
        $accounts[$j] = $acc;
        $j++;

    }

    $fp = fopen(XOOPS_ROOT_PATH . "/uploads/$file_name", 'w');
    fwrite($fp, $csv);
    fclose($fp);
    $xoopsTpl->assign('accounts', $accounts);
    $xoopsTpl->assign('data', $data);

}

/*-----------執行動作判斷區----------*/
$op = Request::getString('op');
$data = Request::getArray('data');

switch ($op) {
    /*---判斷動作請貼在下方---*/

    case "check_set";
        check_set($data);
        break;

    case "add_user";
        $msg = add_user($_POST['data'], $_POST['groupid']);
        $result_msg = adduser_msg($msg);
        redirect_header($_SERVER['PHP_SELF'], 10, $result_msg);
        break;

    default:
        add_user_form();
        $op = 'add_user_form';
        break;
        /*---判斷動作請貼在上方---*/
}

/*-----------秀出結果區--------------*/
$xoopsTpl->assign("now_op", $op);
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tad_users/css/module.css');
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tadtools/css/font-awesome/css/font-awesome.css');
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tadtools/css/vtable.css');
include_once 'footer.php';
