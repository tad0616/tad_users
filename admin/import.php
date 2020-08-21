<?php

use Xmf\Request;
use XoopsModules\Tadtools\Utility;
/*-----------引入檔案區--------------*/
$xoopsOption['template_main'] = "tad_users_admin.tpl";
include_once "header.php";
include_once "../function.php";

/*-----------function區--------------*/
//匯入表單
function import_form()
{

}

//匯入檢查
function import_check()
{
    global $xoopsDB, $xoopsTpl;

    $group_select = group_select("groupid");
    $xoopsTpl->assign('group_select', $group_select);

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
                if (empty($val)) {
                    break 2;
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

/*-----------執行動作判斷區----------*/
$op = Request::getString('op');

switch ($op) {
    /*---判斷動作請貼在下方---*/

    case "import_check";
        import_check();
        break;

    case "add_user";
        $msg = add_user($_POST['data'], $_POST['groupid']);
        $result_msg = adduser_msg($msg);
        redirect_header($_SERVER['PHP_SELF'], 10, $result_msg);
        break;

    default:
        import_form();
        $op = 'import_form';
        break;

        /*---判斷動作請貼在上方---*/
}

/*-----------秀出結果區--------------*/
$xoopsTpl->assign("now_op", $op);
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tad_users/css/module.css');
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tadtools/css/font-awesome/css/font-awesome.css');
$xoTheme->addStylesheet(XOOPS_URL . '/modules/tadtools/css/vtable.css');
include_once 'footer.php';
