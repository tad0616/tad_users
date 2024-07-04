<h2 class="my text-center"><{$smarty.const._MA_TADUSERS_ACCOUNT_GENERATION}></h2>

<form action="add.php" method="post" id="myForm2" enctype="multipart/form-data" class="form-horizontal myForm">
    <div class="form-group row mb-3">
        <label class="col-sm-4 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_IDNUM}>
        </label>
        <div class="col-sm-8">
            <input type="number" name="data[user_num]" id="user_num" class="form-control validate[required]" value="<{$user_num}>" >
        </div>

    </div>

    <div class="form-group row mb-3">
        <label class="col-sm-4 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_IDSTR}>
        </label>
        <div class="col-sm-8">
            <input type="text" name="data[id_str]" id="id_str" class="form-control validate[required]" value="<{$id_str}>" >
        </div>

    </div>

    <div class="form-group row mb-3">
        <label class="col-sm-4 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_IDSTART}>
        </label>
        <div class="col-sm-8">
            <input type="number" name="data[id_start]" id="id_start" class="form-control validate[required]" value="<{$id_start}>" >
        </div>
    </div>

    <div class="form-group row mb-3">
        <label class="col-sm-4 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_INTREST_COL}>
        </label>
        <div class="col-sm-8">
            <input type="text" name="intrest" id="data_intrest" class="form-control " placeholder="<{$smarty.const._MA_TADUSERS_INTREST_COL_DESC}>">
        </div>
    </div>

    <div class="form-group row mb-3">
        <label class="col-sm-4 control-label col-form-label text-md-right  text-md-end">
            <{$smarty.const._MA_TADUSERS_SET_GROUP}>
        </label>
        <div class="col-sm-8">
            <select name="groups[]" multiple id="user_group" class="form-control validate[required]">
                <{foreach from=$group_array key=groupid item=title name=group_array}>
                    <option value="<{$groupid}>" <{if $user.group && ($groupid|in_array:$user.group || $groupid==2)}>selected<{/if}>><{$title}></option>
                <{/foreach}>
            </select>
        </div>
    </div>

    <div class="form-group row mb-3">
        <div class="col-sm-12">

            <div class="input-group mb-2">
                <div class="input-group-append input-group-addon">
                    <span class="input-group-text">
                        <input type="radio" name="data[pass_mode]" id="pass_mode_random" value="random" class="form-check-input my-1 my-1 mr-2 me-2 validate[required]" checked>
                        <{$smarty.const._MA_TADUSERS_RANDOM}>
                    </span>
                </div>
                <input type="number" name="data[pass_num]" id="pass_num" class="form-control"  value="12">
                <div class="input-group-append input-group-addon">
                    <span class="input-group-text">
                        <{$smarty.const._MA_TADUSERS_RANDOM2}>
                    </span>
                </div>
            </div>

            <div class="input-group mb-2">
                <div class="input-group-append input-group-addon">
                    <span class="input-group-text">
                        <input type="radio" name="data[pass_mode]" id="pass_mode_fixed" value="fixed" class="form-check-input my-1 mr-2 me-2 validate[required]">
                        <{$smarty.const._MA_TADUSERS_FIXED}>
                    </span>
                </div>
                <input type="text" name="data[password]" id="password" class="form-control" value=''>
            </div>


            <div class="input-group mb-2">
                <div class="input-group-append input-group-addon">
                    <span class="input-group-text">
                        <input type="radio" name="data[pass_mode]" id="pass_mode_fixed2" value="fixed2" class="form-check-input my-1 my-1 mr-2 me-2 validate[required]">
                        <{$smarty.const._MA_TADUSERS_FIXED2}>
                    </span>
                </div>
                <input type="text" name="data[password2]" id="password2" class="form-control">
            </div>

            <div class="input-group mb-2">
                <div class="input-group-append input-group-addon">
                    <span class="input-group-text">
                        <input type="radio" name="data[pass_mode]" id="pass_mode_same_as_id" value="same_as_id" class="form-check-input my-1 my-1 mr-2 me-2 validate[required]">
                        <{$smarty.const._MA_TADUSERS_SAMEASID}>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <div class="bar">
        <button type="submit" class="btn btn-primary" name="op" value="check_set"><{$smarty.const._MA_TADUSERS_NEXT}></button>
    </div>
</form>