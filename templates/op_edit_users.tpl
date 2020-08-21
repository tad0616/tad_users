<h1 class="my"><{$smarty.const._MA_TADUSERS_EDIT_ACCOUNT|sprintf:$uname}></h1>

<{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_search_bar.tpl"}>

<form action="main.php" method="post" id="myForm" class="mb-4">
    <!-- 上標下格 -->
    <div class="vtable">
        <ul class="vhead">
            <li class="w025 c">uid</li>
            <li class="w1 c"><{$smarty.const._MA_TADUSERS_NAME}></li>
            <li class="w05 c"><{$smarty.const._MA_TADUSERS_UNAME}></li>
            <li class="w1 c"><{$smarty.const._MA_TADUSERS_PASSWD}></li>
            <li class="w1 c">Email</li>
            <li class="w05 c"><{$smarty.const._MA_TADUSERS_TIMEZONE}></li>
            <li class="w1 c"><{$smarty.const._MA_TADUSERS_GROUP}></li>
            <li class="w1 c" data-toggle="tooltip" title="user_occ <{$smarty.const._MA_TADUSERS_COL}>">occ</li>
            <li class="w05 c" data-toggle="tooltip" title="user_intrest <{$smarty.const._MA_TADUSERS_COL}>">intrest</li>
            <li class="w1 c">bio</li>
            <li class="w05 c"><{$smarty.const._TAD_FUNCTION}></li>
        </ul>
        <ul>
            <li class="vcell c">uid</li>
            <li class="vm w025 c"><a href="<{$xoops_url}>/userinfo.php?uid=<{$uid}>"><{$uid}></a></li>
            <li class="vcell c"><{$smarty.const._MA_TADUSERS_NAME}></li>
            <li class="vm w1 c"><input type="text" name="name" id="name" class="form-control validate[required]" value="<{$name}>" placeholder=""></li>
            <li class="vcell c"><{$smarty.const._MA_TADUSERS_UNAME}></li>
            <li class="vm w05 c"><a href="<{$xoops_url}>/userinfo.php?uid=<{$uid}>"><{$uname}></a></li>
            <li class="vcell c"><{$smarty.const._MA_TADUSERS_PASSWD}></li>
            <li class="vm w1 c"><input type="text" name="pass" id="pass" class="form-control " title="要改<{$smarty.const._MA_TADUSERS_PASSWD}>才需填寫" data-toggle="tooltip"></li>
            <li class="vcell c">Email</li>
            <li class="vm w1 c"><input type="text" name="email" id="email" class="form-control validate[required]" value="<{$email}>" placeholder=""></li>
            <li class="vcell c"><{$smarty.const._MA_TADUSERS_TIMEZONE}></li>
            <li class="vm w05 c"><input type="text" name="timezone_offset" id="timezone_offset" class="form-control validate[required]" value="<{$timezone_offset}>" placeholder=""></li>
            <li class="vcell c"><{$smarty.const._MA_TADUSERS_GROUP}></li>
            <li class="vm w1 c"><{$XoopsFormSelectGroup}></li>
            <li class="vcell c">user_occ</li>
            <li class="vm w1 c"><input type="text" name="user_occ" id="user_occ" class="form-control " value="<{$user_occ}>"></li>
            <li class="vcell c">user_intrest</li>
            <li class="vm w05 c"><input type="text" name="user_intrest" id="user_intrest" class="form-control " value="<{$user_intrest}>"></li>
            <li class="vcell c">bio</li>
            <li class="vm w1 c"><input type="text" name="bio" id="bio" class="form-control " value="<{$bio}>"></li>
            <li class="vcell c"><{$smarty.const._TAD_FUNCTION}></li>
            <li class="vm w05 c">
                <input type="hidden" name="op" value="update_user">
                <input type="hidden" name="uid" value="<{$uid}>">
                <input type="hidden" name="g2p" value="<{$smarty.get.g2p}>">
                <button type="submit" class="btn btn-primary"><{$smarty.const._TAD_SUBMIT}></button>
            </li>
        </ul>
    </div>
</form>