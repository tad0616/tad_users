<?php
use Xmf\Request;
use XoopsModules\Tadtools\FormValidator;
use XoopsModules\Tadtools\Utility;
/*-----------引入檔案區--------------*/
$xoopsOption['template_main'] = "tad_users_admin.tpl";
include_once "header.php";
include_once "../function.php";

/*-----------執行動作判斷區----------*/
$op = Request::getString('op');
$data = Request::getArray('data');
$groups = Request::getArray('groups');
$intrest = Request::getString('intrest');

switch ($op) {
    case "check_set";
        check_set($data, $groups, $intrest);
        break;

    case "check_user";
        check_user($data, $groups, $intrest);
        break;

    case "import_check";
        import_check($groups, $intrest);
        break;

    case "add_user";
        $msg = add_user($data, $groups);
        $result_msg = adduser_msg($msg);
        redirect_header($_SERVER['PHP_SELF'], 10, $result_msg);
        break;

    default:
        add_user_form();
        $op = 'add_user_form';
        break;
}

/*-----------秀出結果區--------------*/
$xoopsTpl->assign("now_op", $op);
$xoTheme->addStylesheet('modules/tadtools/css/vtable.css');
include_once 'footer.php';

/*-----------function區--------------*/

//匯入檢查
function import_check($groups = [], $intrest = '')
{
    global $xoopsTpl;

    if (!file_exists($_FILES['userfile']['tmp_name'])) {
        redirect_header($_SERVER['PHP_SELF'], 3, _MA_TADUSERS_FILE_NOT_EXIST);
    }

    $group_array = group_array();
    $xoopsTpl->assign('group_array', $group_array);
    $xoopsTpl->assign('groups', $groups);
    $xoopsTpl->assign('intrest', $intrest);

    require XOOPS_ROOT_PATH . '/modules/tadtools/vendor/phpoffice/phpexcel/Classes/PHPExcel/IOFactory.php';
    $reader = \PHPExcel_IOFactory::createReader('Excel2007');
    $PHPExcel = $reader->load($_FILES['userfile']['tmp_name']); // 檔案名稱

    $sheet = $PHPExcel->getSheet(0); // 讀取第一個工作表(編號從 0 開始)
    $highestRow = $sheet->getHighestRow(); // 取得總列數
    $colString = $sheet->getHighestDataColumn();
    $highestColumn = \PHPExcel_Cell::columnIndexFromString($colString);

    $cell = $sheet->getCellByColumnAndRow(0, 1);
    $val = get_value_of_cell($cell);

    preg_match_all('/\d+/', $val, $matches, PREG_OFFSET_CAPTURE);

    $myts = MyTextSanitizer::getInstance();
    $users = [];
    for ($row = 1; $row <= $highestRow; $row++) {
        //讀取一列中的每一格
        for ($col = 0; $col < $highestColumn; $col++) {
            $cell = $sheet->getCellByColumnAndRow($col, $row);
            $val = $myts->addSlashes(get_value_of_cell($cell));
            $users[$row][$col] = $val;
            if ($col == 0) {
                if (empty($val) or $val == "Account" or $val == "帳號") {
                    unset($users[$row]);
                    continue 2;
                }

                $users[$row]['uname'] = $val;
                $users[$row]['id_existed'] = id_existed($val);
            } elseif ($col == 1) {
                $users[$row]['name'] = $val;
            } elseif ($col == 2) {
                $users[$row]['email'] = $val;
            } elseif ($col == 3) {
                $users[$row]['passwd'] = $val;
            }
        }
    }

    $xoopsTpl->assign('users', $users);

}

//針對excel各種數據類型
function get_value_of_cell($cell = "")
{
    if (is_null($cell)) {
        $value = $cell->setIterateOnlyExistingCells(true);
    } else {
        if (strstr($cell->getValue(), '=')) {
            $value = $cell->getCalculatedValue();
        } elseif ($cell->getValue() instanceof PHPExcel_RichText) {
            $value = $cell->getValue()->getPlainText();
        } elseif (PHPExcel_Shared_Date::isDateTime($cell)) {
            $value = PHPExcel_Shared_Date::ExcelToPHPObject($cell->getValue())->format('Y-m-d');
        } else {
            $value = $cell->getValue();
        }
    }
    return $value;
}

function add_user_form()
{
    global $xoopsTpl;
    $group_array = group_array();
    $xoopsTpl->assign('group_array', $group_array);

    $FormValidator = new FormValidator(".myForm", false);
    $FormValidator->render('topLeft');
}

//新增後的檢查動作
function check_set($data = [], $groups = [], $intrest = '')
{
    global $xoopsTpl;
    $group_array = group_array();
    $xoopsTpl->assign('group_array', $group_array);
    $xoopsTpl->assign('groups', $groups);
    $xoopsTpl->assign('intrest', $intrest);

    $j = $data['id_start'];
    $csv = "";
    $file_name = session_id() . date("YmdHis");
    $xoopsTpl->assign('file_name', $file_name);

    $accounts = [];
    for ($i = 0; $i < $data['user_num']; $i++) {

        //帳號
        $acc['id'] = $acc['name'] = $id = $data['id_str'] . $j;

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

        $acc['email'] = $acc['id'] . '@' . $_SERVER['HTTP_HOST'];

        $passwd = $acc['passwd'];
        if (!$acc['id_existed']) {
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

//新增後的檢查動作
function check_user($data = [], $groups = [], $intrest = '')
{
    global $xoopsTpl;

    $group_array = group_array();
    $xoopsTpl->assign('group_array', $group_array);
    $xoopsTpl->assign('groups', $groups);

    $data['id_existed'] = id_existed($data['uname']);
    $xoopsTpl->assign('acc', $data);
    $xoopsTpl->assign('intrest', $intrest);
}
