<?php
use XoopsModules\Tadtools\Utility;

function group_array()
{
    global $xoopsDB;
    $groups = [];
    $sql = 'SELECT `groupid`, `name` FROM `' . $xoopsDB->prefix('groups') . '`';
    $result = Utility::query($sql) or Utility::web_error($sql, __FILE__, __LINE__);

    while (list($groupid, $name) = $xoopsDB->fetchRow($result)) {
        $groups[$groupid] = $name;
    }
    return $groups;
}

//取得群組下拉選單
function group_select($select_name = "groupid", $value = array(), $js = "", $mode = '')
{
    global $xoopsDB;

    $groupid_count = [];
    $sql = 'SELECT `groupid`, COUNT(`groupid`) FROM `' . $xoopsDB->prefix('groups_users_link') . '` GROUP BY `groupid`';
    $result = Utility::query($sql) or Utility::web_error($sql, __FILE__, __LINE__);

    while (list($groupid, $count) = $xoopsDB->fetchRow($result)) {
        $groupid_count[$groupid] = (int) $count;
    }

    $sql = 'SELECT `groupid`, `name`, `group_type` FROM `' . $xoopsDB->prefix('groups') . '`';
    $result = Utility::query($sql) or Utility::web_error($sql, __FILE__, __LINE__);

    $option = "<option value=''></option>";
    while (list($groupid, $name, $group_type) = $xoopsDB->fetchRow($result)) {
        $selected = (!empty($value) && in_array($groupid, $value)) ? "selected" : "";
        if ($group_type == 'Anonymous') {
            continue;
        }
        $count = (int) $groupid_count[$groupid];
        $option .= "<option value='$groupid' $selected>{$name} ({$count})</option>";
    }
    $main = "
    <select name='{$select_name}' class='form-select group_select' $js>
    $option
    </select>";

    return $main;
}

//檢查帳號是否已經存在
function id_existed($id = "")
{
    global $xoopsDB;

    $sql = 'SELECT `uid` FROM `' . $xoopsDB->prefix('users') . '` WHERE `uname`=?';
    $result = Utility::query($sql, 's', [$id]) or Utility::web_error($sql, __FILE__, __LINE__);

    while (list($uid) = $xoopsDB->fetchRow($result)) {
        if (!empty($uid)) {
            return $uid;
        }

    }
    return false;
}

//新增XOOPS會員
function add_user($data = [], $groups = [])
{
    global $xoopsConfig;

    define('XOOPS_XMLRPC', 1);
    $_SERVER['REQUEST_METHOD'] = 'POST';

    $member_handler = xoops_gethandler('member');

    foreach ($data as $i => $mem) {

        $uname = (empty($mem['uname'])) ? $mem['id'] : $mem['uname'];
        $name = (empty($mem['name'])) ? $mem['id'] : $mem['name'];
        $email = (empty($mem['email'])) ? "{$uname}@{$_SERVER['HTTP_HOST']}" : $mem['email'];
        $intrest = (empty($mem['intrest'])) ? '' : $mem['intrest'];
        $newuser = &$member_handler->createUser();

        $newuser->setVar('uname', $uname);
        $newuser->setVar('name', $name);
        $newuser->setVar('email', $email);
        $newuser->setVar('pass', md5($mem['passwd']));
        $newuser->setVar('user_avatar', 'blank.gif');
        //$actkey = substr(md5(uniqid(mt_rand(), 1)), 0, 8);
        $newuser->setVar('actkey', "tadusers");
        $newuser->setVar('user_regdate', time());
        $newuser->setVar('uorder', $xoopsConfig['com_order']);
        $newuser->setVar('umode', $xoopsConfig['com_mode']);
        $newuser->setVar('level', 1);
        $newuser->setVar('theme', $xoopsConfig['theme_set']);
        $newuser->setVar('timezone_offset', $xoopsConfig['default_TZ']);
        $newuser->setVar('intrest', $intrest);

        if (!$member_handler->insertUser($newuser, true)) {
            $msg['err'][] = "{$mem['id']}";
            continue;
        } else {
            $msg['ok'][] = "{$mem['id']}";
        }
        $newid = $newuser->getVar('uid');

        foreach ($groups as $groupid) {
            if ($groupid == XOOPS_GROUP_USERS) {
                if (!$member_handler->addUserToGroup(XOOPS_GROUP_USERS, $newid)) {
                    $msg['g_err'][] = "{$mem['id']}";
                }
            } else {
                if (!$member_handler->addUserToGroup(XOOPS_GROUP_USERS, $newid) or !$member_handler->addUserToGroup($groupid, $newid)) {
                    $msg['g_err'][] = "{$mem['id']}";
                }
            }
        }

    }
    return $msg;
}

function adduser_msg($msg = array())
{
    $text = _MA_TADUSERS_RESULT;
    foreach ($msg['err'] as $mem) {
        $text .= "<div style='color:red;font-weight:bolder'>{$mem} " . _MA_TADUSERS_ADDID_ERROR . "</div>";
    }
    foreach ($msg['ok'] as $mem) {
        $text .= "<div style='color:black;font-weight:normal'>{$mem} " . _MA_TADUSERS_ADDID_OK . "</div>";
    }
    foreach ($msg['g_err'] as $mem) {
        $text .= "<div style='color:red;font-weight:bolder'>{$mem} " . _MA_TADUSERS_ADDGROUP_ERROR . "</div>";
    }
    return $text;
}
