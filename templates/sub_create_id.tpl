<h2 class="my text-center"><{$smarty.const._MA_TADUSERS_CREATE_ACCOUNT}></h2>

<form action="add.php" method="post" id="myForm1" enctype="multipart/form-data" class="form-horizontal myForm">
    <div class="form-group row mb-3">
        <label class="col-sm-3 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_NAME}>
        </label>
        <div class="col-sm-9">
            <input type="text" name="data[name]" id="data_name" class="form-control validate[required]">
        </div>

    </div>

    <div class="form-group row mb-3">
        <label class="col-sm-3 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_UNAME}>
        </label>
        <div class="col-sm-9">
            <input type="text" name="data[id]" id="data_id" class="form-control validate[required]">
        </div>

    </div>

    <div class="form-group row mb-3">
        <label class="col-sm-3 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_PASS}>
        </label>
        <div class="col-sm-9">
            <input type="text" name="data[passwd]" id="data_passwd" class="form-control validate[required]">
        </div>
    </div>


    <div class="form-group row mb-3">
        <label class="col-sm-3 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_EMAIL}>
        </label>
        <div class="col-sm-9">
            <input type="text" name="data[email]" id="data_email" class="form-control validate[required]">
        </div>
    </div>

    <div class="form-group row mb-3">
        <label class="col-sm-3 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_INTREST_COL}>
        </label>
        <div class="col-sm-9">
            <input type="text" name="data[intrest]" id="data_intrest" class="form-control" placeholder="<{$smarty.const._MA_TADUSERS_INTREST_COL_DESC}>">
        </div>
    </div>


    <div class="form-group row mb-3">
        <label class="col-sm-3 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_SET_GROUP}>
        </label>
        <div class="col-sm-9">
            <select name="groups[]" multiple id="data_group" class="form-select validate[required]">
                <{foreach from=$group_array key=groupid item=title name=group_array}>
                    <option value="<{$groupid|default:''}>" <{if $user.group && ($groupid|in_array:$user.group|| $groupid==2)}>selected<{/if}>><{$title|default:''}></option>
                <{/foreach}>
            </select>
        </div>
    </div>


    <div class="bar">
        <button type="submit" class="btn btn-primary" name="op" value="check_user"><{$smarty.const._MA_TADUSERS_NEXT}></button>
    </div>
</form>