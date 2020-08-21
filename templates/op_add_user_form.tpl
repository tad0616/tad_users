<h1 class="my"><{$smarty.const._MA_TADUSERS_ACCOUNT_GENERATION}></h1>

<form action="add.php" method="post" id="myForm" enctype="multipart/form-data" class="form-horizontal">
<div class="row">
    <div class="col-sm-6">

        <div class="form-group row">
            <label class="col-sm-4 control-label col-form-label text-md-right">
                <{$smarty.const._MA_TADUSERS_IDNUM}>
            </label>
            <div class="col-sm-8">
                <input type="text" name="data[user_num]" id="user_num" class="form-control validate[required]" value="<{$user_num}>" >
            </div>

        </div>

        <div class="form-group row">
            <label class="col-sm-4 control-label col-form-label text-md-right">
                <{$smarty.const._MA_TADUSERS_IDSTR}>
            </label>
            <div class="col-sm-8">
                <input type="text" name="data[id_str]" id="id_str" class="form-control validate[required]" value="<{$id_str}>" >
            </div>

        </div>

        <div class="form-group row">
            <label class="col-sm-4 control-label col-form-label text-md-right">
                <{$smarty.const._MA_TADUSERS_IDSTART}>
            </label>
            <div class="col-sm-8">
                <input type="text" name="data[id_start]" id="id_start" class="form-control validate[required]" value="<{$id_start}>" >
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-4 control-label col-form-label text-md-right">
                <{$smarty.const._MA_TADUSERS_OFGROUP}>
            </label>
            <div class="col-sm-8">
                <{$group_select}>
            </div>

        </div>
    </div>
    <div class="col-sm-6">
        <div class="form-group row">
            <label class="col-sm-4 control-label col-form-label text-md-right">
                <{$smarty.const._MA_TADUSERS_PASS_MODE}>
            </label>
            <div class="col-sm-8">

                <div class="input-group">
                    <div class="input-group-prepend input-group-addon">
                        <span class="input-group-text">
                            <input type="radio" name="data[pass_mode]" id="pass_mode_same_as_id" value="same_as_id" class="validate[required]">
                        </span>
                    </div>
                    <div class="input-group-append input-group-addon">
                        <span class="input-group-text">
                            <{$smarty.const._MA_TADUSERS_SAMEASID}>
                        </span>
                    </div>
                </div>

                <div class="input-group">
                    <div class="input-group-prepend input-group-addon">
                        <span class="input-group-text">
                            <input type="radio" name="data[pass_mode]" id="pass_mode_random" value="random" class="validate[required]">
                        </span>
                    </div>
                    <div class="input-group-append input-group-addon">
                        <span class="input-group-text">
                            <{$smarty.const._MA_TADUSERS_RANDOM}>
                        </span>
                    </div>
                    <input type="text" name="data[pass_num]" id="pass_num" class="form-control" >
                    <div class="input-group-append input-group-addon">
                        <span class="input-group-text">
                            <{$smarty.const._MA_TADUSERS_RANDOM2}>
                        </span>
                    </div>
                </div>

                <div class="input-group">
                    <div class="input-group-prepend input-group-addon">
                        <span class="input-group-text">
                            <input type="radio" name="data[pass_mode]" id="pass_mode_fixed" value="fixed" class="validate[required]">
                        </span>
                    </div>
                    <div class="input-group-append input-group-addon">
                        <span class="input-group-text">
                            <{$smarty.const._MA_TADUSERS_FIXED}>
                        </span>
                    </div>
                    <input type="text" name="data[password]" id="password" class="form-control " value="" >
                </div>

                <div class="input-group">
                    <div class="input-group-prepend input-group-addon">
                        <span class="input-group-text">
                            <input type="radio" name="data[pass_mode]" id="pass_mode_fixed2" value="fixed2" class="validate[required]">
                        </span>
                    </div>
                    <div class="input-group-append input-group-addon">
                        <span class="input-group-text">
                            <{$smarty.const._MA_TADUSERS_FIXED2}>
                        </span>
                    </div>
                    <input type="text" name="data[password2]" id="password2" class="form-control" value="" >
                </div>
            </div>
        </div>
    </div>
</div>



    <div class="bar">
        <button type="submit" class="btn btn-primary" name="op" value="check_set"><{$smarty.const._MA_TADUSERS_NEXT}></button>
    </div>
</form>