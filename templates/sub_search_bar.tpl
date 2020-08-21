<div class="alert alert-info">
    <div class="row">
        <div class="col-sm-4">
            <div class="input-group">
                <div class="input-group-prepend input-group-addon">
                    <span class="input-group-text"><{$smarty.const._MA_TADUSERS_ONLY_LIST}></span>
                </div>
                <{$select}>
                <div class="input-group-append input-group-addon">
                    <span class="input-group-text"><{$smarty.const._MA_TADUSERS_GROUP_USERS}></span>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <form action="main.php" method="post">
                <div class="input-group">
                    <div class="input-group-prepend input-group-addon">
                        <span class="input-group-text"><{$smarty.const._MA_TADUSERS_SEARCH_USER}></span>
                    </div>
                    <input type="text" name="key" class="form-control" placeholder="請輸入關鍵字">
                    <div class="input-group-append input-group-btn">
                        <button type="submit" class="btn btn-primary"><{$smarty.const._MA_TADUSERS_SEARCH}></button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>