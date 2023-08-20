<h2 class="my text-center"><{$smarty.const._MA_TADUSERS_IMPORT_ACCOUNT}></h2>

<div class="my-2"><{$smarty.const._MA_TADUSERS_IMPORT_README}></div>

<div class="bg-white"><{$smarty.const._MA_TADUSERS_EXCEL_COL}></div>

<form action="add.php" method="post" enctype="multipart/form-data">

    <div class="form-group row mb-3">
        <label class="col-sm-3 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_IMPORT_FILE}>
        </label>
        <div class="col-sm-9">
            <input type="file" class="form-control validate[required]" name="userfile" id="userfile" accept=".xlsx">
        </div>
    </div>

    <div class="form-group row mb-3">
        <label class="col-sm-3 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_INTREST_COL}>
        </label>
        <div class="col-sm-9">
            <input type="text" name="intrest" id="data_intrest" class="form-control " placeholder="<{$smarty.const._MA_TADUSERS_INTREST_COL_DESC}>">
        </div>
    </div>

    <div class="form-group row mb-3">
        <label class="col-sm-3 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_SET_GROUP}>
        </label>
        <div class="col-sm-9">
            <select name="groups[]" multiple id="user_group" class="form-control validate[required]">
                <{foreach from=$group_array key=groupid item=title name=group_array}>
                    <option value="<{$groupid}>" <{if $groupid|in_array:$user.group|| $groupid==2}>selected<{/if}>><{$title}></option>
                <{/foreach}>
            </select>
        </div>
    </div>


    <div class="bar">
        <button type="submit" name="op" value="import_check" class="btn btn-primary"><{$smarty.const._MA_TADUSERS_IMPORT}></button>
    </div>

</form>
