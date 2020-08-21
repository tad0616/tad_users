<h1 class="my"><{$smarty.const._MA_TADUSERS_IMPORT_ACCOUNT}></h1>

<form action="import.php" method="post" enctype="multipart/form-data">
	<{$smarty.const._MA_TADUSERS_IMPORT_FILE}><INPUT type="file" name="userfile">
	<button type="submit" name="op" value="import_check"><{$smarty.const._MA_TADUSERS_IMPORT}></button>
</form>

<h3 class="my"><{$smarty.const._MA_TADUSERS_IMPORT_README}></h3>

<div class="bg-white"><{$smarty.const._MA_TADUSERS_EXCEL_COL}></div>