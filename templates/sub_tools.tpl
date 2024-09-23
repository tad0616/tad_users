<div class="input-group">
    <div class="input-group-prepend input-group-addon">
        <span class="input-group-text"><{$smarty.const._MA_TADUSERS_CHECKMARK_MEMBER}></span>
    </div>
    <select name="op1" id="op1" class="form-control validate[required]" placeholder="<{$smarty.const._MA_TADUSERS_SELECT_ACTION}>">
        <option value=""></option>
        <option value="add_group"><{$smarty.const._MA_TADUSERS_JOIN_TO_GROUP}></option>
        <option value="del_group"><{$smarty.const._MA_TADUSERS_MOVE_OUT_GROUP}></option>
        <option value="update_timezone_offset"><{$smarty.const._MA_TADUSERS_UPDATE_TIMEZONE}></option>
        <option value="update_theme"><{$smarty.const._MA_TADUSERS_UPDATE_THEME}></option>
        <option value="del_users"><{$smarty.const._MA_TADUSERS_DEL_USERS}></option>
    </select>
    <div class="input-group-prepend input-group-addon">
        <span class="input-group-text"><{$smarty.const._TAD_FOR}></span>
    </div>


    <{$group_select|default:''}>
    <div class="input-group-apppend input-group-addon group_select">
        <span class="input-group-text"><{$smarty.const._MA_TADUSERS_GROUPS}></span>
    </div>

    <input type="text" name="val" class="form-control val_input" style="display: none;">


    <div class="input-group-append input-group-btn">
        <button type="submit" class="btn btn-primary"><{$smarty.const._MA_TADUSERS_GO}></button>
    </div>
</div>