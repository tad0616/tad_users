<?php

use Xmf\Request;
use XoopsModules\Tadtools\Bootstrap3Editable;
use XoopsModules\Tadtools\FooTable;
use XoopsModules\Tadtools\FormValidator;
use XoopsModules\Tadtools\Utility;
/*-----------引入檔案區--------------*/
$xoopsOption['template_main'] = "tad_users_admin.tpl";
include_once "header.php";
include_once "../function.php";

/*-----------執行動作判斷區----------*/
$op = Request::getString('op');
$op1 = Request::getString('op1');
$op2 = Request::getString('op2');
$uid = Request::getInt('uid');
$g2p = Request::getInt('g2p', 1);
$groupid = Request::getInt('groupid');
$act_groupid = Request::getInt('act_groupid');
$key = Request::getString('key');
$sort = Request::getString('sort', 'uid');
$desc = Request::getString('desc');
$val = Request::getString('val');

if (!empty($op1)) {
    $op = $op1;
} elseif (!empty($op2)) {
    $op = $op2;
}

switch ($op) {
    case "update_user":
        update_user($uid);
        header("location:main.php?g2p=$g2p");
        exit;

    case "edit_users":
        edit_users($uid);
        break;

    case "add_group":
        add_group($act_groupid);
        header("location:main.php?groupid=$act_groupid");
        exit;

    case "del_group":
        del_group($act_groupid);
        header("location:main.php?groupid=$act_groupid");
        exit;

    case "del_users":
        del_users();
        header("location:{$_SERVER['HTTP_REFERER']}");
        exit;

    case "update_timezone_offset":
        update_users_value('timezone_offset', $val);
        header("location:{$_SERVER['HTTP_REFERER']}");
        exit;

    case "update_theme":
        update_users_value('theme', $val);
        header("location:{$_SERVER['HTTP_REFERER']}");
        exit;

    case "check_members":
        check_members($groupid);
        break;

    case 'clear_uid0':
        clear_uid0($groupid);
        header("location:main.php?op=check_members&groupid=$groupid");
        exit;

    default:
        list_users($groupid, $key, $sort, $desc);
        $op = 'list_users';
        break;
}

/*-----------秀出結果區--------------*/
$xoopsTpl->assign("now_op", $op);
$xoTheme->addStylesheet('/modules/tadtools/css/font-awesome/css/font-awesome.css');
$xoTheme->addStylesheet(XOOPS_URL . "/modules/tadtools/css/xoops_adm{$_SEESION['bootstrap']}.css");
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tadtools/css/my-input.css');
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tad_users/css/module.css');
include_once 'footer.php';

/*-----------function區--------------*/

function clear_uid0($groupid = '')
{
    global $xoopsTpl, $xoopsDB;

    $sql = "delete from " . $xoopsDB->prefix("groups_users_link") . " where uid='0' and groupid='{$groupid}'";
    $xoopsDB->queryF($sql) or Utility::web_error($sql, __FILE__, __LINE__);
}

function check_members($groupid = '')
{
    global $xoopsTpl, $xoopsDB, $xoopsConfig;

    $Bootstrap3Editable = new Bootstrap3Editable();
    $Bootstrap3EditableCode = $Bootstrap3Editable->render('.editable', XOOPS_URL . '/modules/tad_users/admin/ajax.php');
    $xoopsTpl->assign('Bootstrap3EditableCode', $Bootstrap3EditableCode);
    $FooTable = new FooTable('.footable');
    $FooTable->render();
    $group_select = group_select("act_groupid");
    $xoopsTpl->assign('group_select', $group_select);
    $xoopsTpl->assign('groupid', $groupid);
    $select = group_select("groupid", array($groupid), "onChange=\"location.href='main.php?groupid='+this.value\"");
    $xoopsTpl->assign('select', $select);
    $group_array = group_array();
    $xoopsTpl->assign('group_array', $group_array);

    $sql = "select count(`uid`) from " . $xoopsDB->prefix("groups_users_link") . " where uid='0'";
    $result = $xoopsDB->query($sql) or Utility::web_error($sql, __FILE__, __LINE__);
    list($no_uid_members) = $xoopsDB->fetchRow($result);
    $xoopsTpl->assign('no_uid_members', $no_uid_members);

    $users = [];
    if ($groupid != 2) {
        $members = [];
        $sql = "select a.`uid` from " . $xoopsDB->prefix("users") . " as a join " . $xoopsDB->prefix("groups_users_link") . " as b on a.uid=b.uid where b.groupid='2'";
        $result = $xoopsDB->query($sql) or Utility::web_error($sql, __FILE__, __LINE__);
        while (list($uid) = $xoopsDB->fetchRow($result)) {
            $members[$uid] = $uid;
        }
    }

    $sql = "select a.* from " . $xoopsDB->prefix("users") . " as a join " . $xoopsDB->prefix("groups_users_link") . " as b on a.uid=b.uid where b.groupid='$groupid'";
    $result = $xoopsDB->query($sql) or Utility::web_error($sql, __FILE__, __LINE__);
    while ($user = $xoopsDB->fetchArray($result)) {
        if ($groupid != 2 && !in_array($user['uid'], $members)) {
            $user['ng'][] = _MA_TADUSERS_NOT_MEMBER;
        }
        if ($xoopsConfig['default_TZ'] != $user['timezone_offset']) {
            $user['ng'][] = sprintf(_MA_TADUSERS_TIMEZONE_NG, $user['timezone_offset'], $xoopsConfig['default_TZ']);
        }
        if (empty($user['theme'])) {
            $user['ng'][] = sprintf(_MA_TADUSERS_THEME_NG, $user['theme'], $xoopsConfig['theme_set']);
        } elseif ($xoopsConfig['theme_set'] != $user['theme']) {
            $user['ng'][] = sprintf(_MA_TADUSERS_THEME_NG2, $user['theme'], $xoopsConfig['theme_set']);
        }
        if (!empty($user['ng'])) {

            $user['groups'] = user_groups($user['uid'], $group_array);
            $user['bio_list'] = user_bio($user['bio']);
            $users[] = $user;
        }

    }
    $xoopsTpl->assign('users', $users);

}

function user_groups($uid, $group_array = [])
{
    $member_handler = xoops_gethandler('member');
    $groups = $member_handler->getGroupsByUser($uid);
    $group_arr = [];
    foreach ($groups as $groupid) {
        $group_arr[$groupid] = $group_array[$groupid];
    }
    return arrayToUl($group_arr, false);
}

function user_bio($bio)
{
    $bio_arr = json_decode($bio, true);
    if (json_last_error() == JSON_ERROR_NONE) {
        return arrayToUl($bio_arr);
    }
    return;
}

function arrayToUl($array, $show_key = true)
{
    $html = "<ul>";
    foreach ($array as $key => $value) {
        $html .= $show_key ? '<li>' . $key : '<li>';

        if (is_array($value)) {
            $html .= arrayToUl($value); // 遞迴呼叫處理子陣列
        } else {
            $html .= $show_key ? ': ' . $value : $value;
        }

        $html .= '</li>';
    }
    $html .= '</ul>';
    return $html;
}

function list_users($groupid = "", $key = "", $sort = 'uid', $desc = 'desc')
{
    global $xoopsDB, $xoopsTpl;

    $Bootstrap3Editable = new Bootstrap3Editable();
    $Bootstrap3EditableCode = $Bootstrap3Editable->render('.editable', XOOPS_URL . '/modules/tad_users/admin/ajax.php');
    $xoopsTpl->assign('Bootstrap3EditableCode', $Bootstrap3EditableCode);
    $FooTable = new FooTable('.footable');
    $FooTable->render();

    $xoopsTpl->assign('groupid', $groupid);
    $xoopsTpl->assign('key', $key);
    $desc = $desc == 'desc' ? '' : 'desc';
    $xoopsTpl->assign('desc', $desc);
    $xoopsTpl->assign('sort', $sort);

    $and_key = empty($key) ? '' : "and (a.name like '%$key%' or a.uname like '%$key%' or a.email like '%$key%' or a.user_occ like '%$key%' or a.bio like '%$key%' or a.user_intrest like '%$key%')";
    if (empty($groupid)) {
        $sql = "select a.* from " . $xoopsDB->prefix("users") . " as a where 1 $and_key order by `$sort` $desc";
    } else {
        $sql = "select a.* from " . $xoopsDB->prefix("users") . " as a join " . $xoopsDB->prefix("groups_users_link") . " as b on a.uid=b.uid where b.groupid='$groupid' $and_key group by a.`uid` order by a.`$sort` $desc";
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

    $group_select = group_select("act_groupid");
    $xoopsTpl->assign('group_select', $group_select);

    $group_array = group_array();
    $xoopsTpl->assign('group_array', $group_array);
    $users = [];
    while ($user = $xoopsDB->fetchArray($result)) {
        foreach ($user as $k => $v) {
            $$k = $v;
        }
        $user['groups'] = user_groups($uid, $group_array);
        $user['bio_list'] = user_bio($bio);
        $user['user_regdate'] = date("Y/m/d", $user_regdate);
        $user['last_login'] = empty($last_login) ? "" : date("Y/m/d H:i:s", $last_login);
        $users[] = $user;
    }
    $xoopsTpl->assign('users', $users);
    //加入Token安全機制
    include_once XOOPS_ROOT_PATH . "/class/xoopsformloader.php";
    $token = new \XoopsFormHiddenToken();
    $token_form = $token->render();
    $xoopsTpl->assign("token_form", $token_form);
}

function edit_users($uid = "")
{
    global $xoopsDB, $xoopsTpl;
    $FormValidator = new FormValidator(".myForm", false);
    $FormValidator->render('topLeft');

    $member_handler = xoops_gethandler('member');
    $userGroups = $member_handler->getGroupsByUser($uid);
    $xoopsTpl->assign('userGroups', $userGroups);
    $select = group_select("groupid", [], "onChange=\"location.href='main.php?groupid='+this.value\"");
    $xoopsTpl->assign('select', $select);

    $sql = "select * from " . $xoopsDB->prefix("users") . " where uid='$uid'";
    $result = $xoopsDB->query($sql) or Utility::web_error($sql, __FILE__, __LINE__);

    $users = $xoopsDB->fetchArray($result);
    $users = array_map('htmlspecialchars', $users);
    $xoopsTpl->assign('user', $users);

    require XOOPS_ROOT_PATH . "/class/xoopsformloader.php";
    $form = new \XoopsFormSelectGroup("", "group", false, $userGroups, 6, true);
    $form->setExtra("class='form-control'");
    $xoopsTpl->assign('XoopsFormSelectGroup', $form->render());
}

function update_user($uid = "")
{
    global $xoopsDB;
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
        $xoopsDB->queryF($sql) or Utility::web_error($sql, __FILE__, __LINE__);
    }
}

function add_group($groupid)
{
    global $xoopsDB;
    foreach ($_POST['uid_arr'] as $uid) {
        $sql = "insert into " . $xoopsDB->prefix("groups_users_link") . " (`groupid` , `uid`) values('$groupid','$uid')";
        $xoopsDB->queryF($sql) or Utility::web_error($sql, __FILE__, __LINE__);
    }
}

function del_group($groupid)
{
    global $xoopsDB;
    foreach ($_POST['uid_arr'] as $uid) {
        $sql = "delete from " . $xoopsDB->prefix("groups_users_link") . "  where `uid`='$uid' and `groupid`='$groupid'";
        $result = $xoopsDB->queryF($sql) or Utility::web_error($sql, __FILE__, __LINE__);
    }
}

function update_users_value($name, $value)
{
    global $xoopsDB;

    foreach ($_POST['uid_arr'] as $uid) {
        $sql = "update " . $xoopsDB->prefix("users") . " set `{$name}`='{$value}' where uid='$uid'";
        $xoopsDB->queryF($sql) or Utility::web_error($sql, __FILE__, __LINE__);
    }
    return $value;

}

//
function del_users()
{
    $member_handler = xoops_getHandler('member');
    if (!$GLOBALS['xoopsSecurity']->check()) {
        redirect_header('main.php', 3, implode('<br>', $GLOBALS['xoopsSecurity']->getErrors()));
    }

    if (@isset($_POST['uid_arr']) || @$_POST['uid_arr'] !== '') {
        $error = '';
        foreach ($_POST['uid_arr'] as $uid) {
            $uid = (int) $uid;
            $user = $member_handler->getUser($uid);
            $groups = $user->getGroups();
            if (in_array(XOOPS_GROUP_ADMIN, $groups)) {
                $error .= sprintf(_MA_TADUSERS_NO_ADMINSUPP, $user->getVar('uname'));
            } elseif (!$member_handler->deleteUser($user)) {
                $error .= sprintf(_MA_TADUSERS_NO_SUPP, $user->getVar('uname'));
            } else {
                /* @var XoopsOnlineHandler $online_handler */
                $online_handler = xoops_getHandler('online');
                $online_handler->destroy($uid);
                // RMV-NOTIFY
                xoops_notification_deletebyuser($uid);
            }
        }
        if ($error !== '') {
            redirect_header('main.php', 3, sprintf(_MA_TADUSERS_USERS_ERROR, $error));
        } else {
            redirect_header('main.php', 1, _MA_TADUSERS_DBUPDATED);
        }
    }
}
