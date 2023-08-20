<div class="alert alert-info">
    <div class="row">
        <div class="col-sm-3">
            <div class="input-group">
                <div class="input-group-prepend input-group-addon">
                    <span class="input-group-text"><{$smarty.const._MA_TADUSERS_ONLY_LIST}></span>
                </div>
                <{$select}>
                <div class="input-group-append input-group-addon">
                    <span class="input-group-text"><{$smarty.const._MA_TADUSERS_GROUP_USERS}></span>
                </div>
                <{if $smarty.get.groupid!=''}>
                    <div class="input-group-append input-group-btn">
                        <button type="submit" class="btn btn-success" name="op" value="check_members"><{$smarty.const._MA_TADUSERS_MEMBER_CHECK}></button>
                    </div>
                <{/if}>
            </div>
        </div>
        <div class="col-sm-6">
            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_tools.tpl"}>
        </div>
        <div class="col-sm-3">
            <div class="input-group">
                <div class="input-group-prepend input-group-addon">
                    <span class="input-group-text"><{$smarty.const._MA_TADUSERS_SEARCH_USER}></span>
                </div>
                <input type="text" name="key" class="form-control" placeholder="<{$smarty.const._MA_TADUSERS_INPUT_KEYWORD}>">
                <div class="input-group-append input-group-btn">
                    <button type="submit" class="btn btn-primary"><{$smarty.const._MA_TADUSERS_SEARCH}></button>
                </div>
            </div>
        </div>
    </div>
</div>