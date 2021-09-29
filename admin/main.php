<?php

use Xmf\Request;
use XoopsModules\Tadtools\Bootstrap3Editable;
use XoopsModules\Tadtools\FooTable;
use XoopsModules\Tadtools\Utility;

/*-----------引入檔案區--------------*/
$xoopsOption['template_main'] = "tad_users_admin.tpl";
include_once "header.php";
include_once "../function.php";

/*-----------function區--------------*/

function list_users($groupid = "", $key = "")
{
    global $xoopsDB, $xoopsTpl;

    $Bootstrap3Editable = new Bootstrap3Editable();
    $Bootstrap3EditableCode = $Bootstrap3Editable->render('.editable', XOOPS_URL . '/modules/tad_users/admin/ajax.php');
    $xoopsTpl->assign('Bootstrap3EditableCode', $Bootstrap3EditableCode);

    $and_key = empty($key) ? '' : "and (a.name like '%$key%' or a.uname like '%$key%' or a.email like '%$key%' or a.user_occ like '%$key%' or a.bio like '%$key%' or a.user_intrest like '%$key%')";
    if (empty($groupid)) {
        $sql = "select a.* from " . $xoopsDB->prefix("users") . " as a where 1 $and_key group by uid";
    } else {
        $sql = "select a.* from " . $xoopsDB->prefix("users") . " as a join " . $xoopsDB->prefix("groups_users_link") . " as b on a.uid=b.uid where b.groupid='$groupid' $and_key group by uid";
    }

    //getPageBar($原sql語法, 每頁顯示幾筆資料, 最多顯示幾個頁數選項);
    $PageBar = Utility::getPageBar($sql, 20, 10);
    $bar = $PageBar['bar'];
    $sql = $PageBar['sql'];
    $total = $PageBar['total'];

    $xoopsTpl->assign('bar', $bar);
    $xoopsTpl->assign('total', $total);

    $result = $xoopsDB->query($sql) or Utility::web_error($sql, __FILE__, __LINE__);

    $select = group_select("groupid", array($groupid), "onChange=\"location.href='main.php?groupid='+this.value\"");
    $xoopsTpl->assign('select', $select);

    $users = [];
    while ($user = $xoopsDB->fetchArray($result)) {
        foreach ($user as $k => $v) {
            $$k = $v;
        }

        $user['user_regdate'] = date("Y年m月d日", $user_regdate);
        $user['last_login'] = empty($last_login) ? "" : date("Y年m月d日", $last_login);
        $users[] = $user;
    }
    $xoopsTpl->assign('users', $users);
    $FooTable = new FooTable('.footable');
    $FooTable->render();

}

function edit_users($uid = "")
{
    global $xoopsDB, $xoopsTpl;

    $member_handler = xoops_gethandler('member');
    $userGroups = $member_handler->getGroupsByUser($uid);
    $xoopsTpl->assign('userGroups', $userGroups);
    $select = group_select("groupid", array($groupid), "onChange=\"location.href='main.php?groupid='+this.value\"");
    $xoopsTpl->assign('select', $select);

    $sql = "select * from " . $xoopsDB->prefix("users") . " where uid='$uid'";
    $result = $xoopsDB->query($sql) or Utility::web_error($sql, __FILE__, __LINE__);

    $users = $xoopsDB->fetchArray($result);
    $xoopsTpl->assign('user', $users);

    require XOOPS_ROOT_PATH . "/class/xoopsformloader.php";
    $form = new \XoopsFormSelectGroup("", "group", false, $userGroups, 3, true);
    $form->setExtra("class='form-control'");
    $xoopsTpl->assign('XoopsFormSelectGroup', $form->render());
}

function update_user($uid = "")
{
    global $xoopsDB, $xoopsTpl;
    $myts = \MyTextSanitizer::getInstance();

    $and_pass = "";
    if (!empty($_POST['pass'])) {
        $pass = md5($_POST['pass']);
        $and_pass = ",pass='{$pass}'";
    }
    $user_occ = $myts->addSlashes($_POST['user_occ']);
    $bio = $myts->addSlashes($_POST['bio']);

    $sql = "update " . $xoopsDB->prefix("users") . " set `user_occ`='{$user_occ}', `bio`='{$bio}'{$and_pass} where `uid`='$uid'";
    $result = $xoopsDB->query($sql) or Utility::web_error($sql, __FILE__, __LINE__);

    //更新群組
    $sql = "delete from " . $xoopsDB->prefix("groups_users_link") . "  where uid='$uid'";
    $result = $xoopsDB->queryF($sql) or Utility::web_error($sql, __FILE__, __LINE__);
    foreach ($_POST['group'] as $group_id) {
        $group_id = (int) $group_id;
        $sql = "insert into " . $xoopsDB->prefix("groups_users_link") . " (`groupid` , `uid`) values('$group_id','$uid')";
        $result = $xoopsDB->queryF($sql) or Utility::web_error($sql, __FILE__, __LINE__);
    }
}

/*-----------執行動作判斷區----------*/
$op = Request::getString('op');
$uid = Request::getInt('uid');
$g2p = Request::getInt('g2p', 1);
$groupid = Request::getInt('groupid');
$key = Request::getString('key');

switch ($op) {
    case "update_user":
        update_user($uid);
        header("location:main.php?g2p=$g2p");
        exit;

    case "edit_users":
        edit_users($uid);
        break;

    default:
        list_users($groupid, $key);
        $op = 'list_users';
        break;
}

/*-----------秀出結果區--------------*/
$xoopsTpl->assign("now_op", $op);
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tad_users/css/module.css');
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tadtools/css/font-awesome/css/font-awesome.css');
include_once 'footer.php';
