<?php
use Xmf\Request;
use XoopsModules\Tadtools\Utility;

require_once dirname(dirname(dirname(__DIR__))) . '/include/cp_header.php';
xoops_loadLanguage('main', $xoopsModule->getVar('dirname'));
xoops_loadLanguage('admin', $xoopsModule->getVar('dirname'));
require_once dirname(__DIR__) . '/function.php';

$op = Request::getString('op');
$name = Request::getString('name');
$value = Request::getString('value');
$pk = Request::getInt('pk');
$uid = Request::getInt('uid') ?: $pk;

switch ($op) {
    case "update_value":
        echo update_value($name, $value, $uid);
        break;

    case "list_users":
        list_users(
            Request::getInt('groupid'),
            Request::getString('search') ?: Request::getString('key'),
            Request::getString('sort', 'uid'),
            Request::getString('order', 'desc'),
            Request::getInt('limit', 20),
            Request::getInt('offset')
        );
        break;
}

function list_users($groupid, $keyword, $sort, $order, $limit, $offset)
{
    global $xoopsDB;

    $sortable = ['uid', 'name', 'uname', 'email', 'timezone_offset', 'theme', 'last_login', 'user_icq', 'user_occ', 'user_intrest', 'bio'];
    $sort = in_array($sort, $sortable, true) ? $sort : 'uid';
    $order = strtolower($order) === 'asc' ? 'ASC' : 'DESC';
    $limit = max(1, min(200, $limit));
    $offset = max(0, $offset);

    $from = '`' . $xoopsDB->prefix('users') . '` AS a';
    $where = '1';
    $types = '';
    $params = [];
    if (!empty($groupid)) {
        $from .= ' JOIN `' . $xoopsDB->prefix('groups_users_link') . '` AS b ON a.`uid`=b.`uid`';
        $where .= ' AND b.`groupid`=?';
        $types .= 'i';
        $params[] = $groupid;
    }
    if ($keyword !== '') {
        $where .= ' AND (a.`name` LIKE ? OR a.`uname` LIKE ? OR a.`email` LIKE ? OR a.`user_occ` LIKE ? OR a.`bio` LIKE ? OR a.`user_intrest` LIKE ?)';
        $types .= 'ssssss';
        $params = array_merge($params, array_fill(0, 6, '%' . $keyword . '%'));
    }

    $sql = "SELECT COUNT(DISTINCT a.`uid`) FROM {$from} WHERE {$where}";
    $result = Utility::query($sql, $types, $params) or Utility::web_error($sql, __FILE__, __LINE__);
    list($total) = $xoopsDB->fetchRow($result);

    $sql = "SELECT a.`uid`, a.`name`, a.`uname`, a.`email`, a.`timezone_offset`, a.`theme`, a.`last_login`, a.`user_icq`, a.`user_occ`, a.`user_intrest`, a.`bio`, a.`actkey` FROM {$from} WHERE {$where} GROUP BY a.`uid` ORDER BY a.`{$sort}` {$order} LIMIT {$limit} OFFSET {$offset}";
    $result = Utility::query($sql, $types, $params) or Utility::web_error($sql, __FILE__, __LINE__);

    $users = [];
    while ($user = $xoopsDB->fetchArray($result)) {
        $users[(int) $user['uid']] = $user;
    }

    $user_groups = [];
    if ($users) {
        $group_array = group_array();
        $sql = 'SELECT `uid`, `groupid` FROM `' . $xoopsDB->prefix('groups_users_link') . '` WHERE `uid` IN (' . implode(',', array_keys($users)) . ')';
        $result = Utility::query($sql) or Utility::web_error($sql, __FILE__, __LINE__);
        while (list($u, $g) = $xoopsDB->fetchRow($result)) {
            $user_groups[$u][] = $group_array[$g] ?? $g;
        }
    }

    $rows = [];
    foreach ($users as $uid => $user) {
        $groups_html = '<ul>';
        foreach ($user_groups[$uid] ?? [] as $group_name) {
            $groups_html .= '<li>' . htmlspecialchars((string) $group_name, ENT_QUOTES) . '</li>';
        }
        $groups_html .= '</ul>';

        $from_sys = $user['actkey'] === 'tadusers' ? ' <img src="' . XOOPS_URL . '/modules/tad_users/images/people.png" alt="' . _MA_TADUSERS_FROM_SYS . '" title="' . _MA_TADUSERS_FROM_SYS . '">' : '';

        $rows[] = [
            'del' => '<a href="' . XOOPS_URL . '/modules/system/admin.php?fct=users&op=users_delete&uid=' . $uid . '" target="_blank" class="btn btn-danger btn-sm btn-xs">' . _MA_TADUSERS_DEL . '</a>',
            'chk' => '<input class="form-check-input uid" type="checkbox" name="uid_arr[]" value="' . $uid . '">',
            'uid' => $uid,
            'name' => $user['name'],
            'uname' => '<a href="' . XOOPS_URL . '/modules/system/admin.php?fct=users&op=users_edit&uid=' . $uid . '">' . htmlspecialchars((string) $user['uname'], ENT_QUOTES) . '</a>' . $from_sys,
            'email' => $user['email'],
            'func' => '<a href="main.php?op=edit_users&uid=' . $uid . '" class="btn btn-warning btn-sm btn-xs" data-bs-toggle="tooltip" data-toggle="tooltip" data-html="true" data-bs-html="true" title="' . htmlspecialchars($groups_html, ENT_QUOTES) . '">' . _MA_TADUSERS_EDIT . '</a>',
            'timezone_offset' => $user['timezone_offset'],
            'theme' => $user['theme'],
            'last_login' => empty($user['last_login']) ? '' : date('Y/m/d H:i:s', (int) $user['last_login']),
            'user_icq' => $user['user_icq'],
            'user_occ' => $user['user_occ'],
            'user_intrest' => $user['user_intrest'],
            'bio' => '<span>' . htmlspecialchars((string) $user['bio'], ENT_QUOTES) . '</span>',
        ];
    }

    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['total' => (int) $total, 'rows' => $rows], JSON_UNESCAPED_UNICODE | JSON_INVALID_UTF8_SUBSTITUTE);
    exit;
}

function update_value($name, $value, $uid)
{
    global $xoopsDB;

    $editable_cols = ['name', 'email', 'timezone_offset', 'theme', 'user_icq', 'user_occ', 'user_intrest'];
    if (!in_array($name, $editable_cols, true) || empty($uid)) {
        http_response_code(400);
        return '';
    }

    $sql = 'UPDATE `' . $xoopsDB->prefix('users') . '` SET `' . $name . '`=? WHERE `uid`=?';
    Utility::query($sql, 'si', [$value, $uid]) or Utility::web_error($sql, __FILE__, __LINE__);

    return $value;

}
