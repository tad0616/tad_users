<h1 class="my"><{$smarty.const._MA_TADUSERS_EDIT_ACCOUNT|sprintf:$uname}></h1>

<{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_search_bar.tpl"}>

<form action="main.php" method="post" id="myForm" class="mb-4">

    <table class="table table-hover table-striped">
        <tr>
            <th class="c">uid</th>
            <th class="c"><{$smarty.const._MA_TADUSERS_NAME}></th>
            <th class="c"><{$smarty.const._MA_TADUSERS_UNAME}></th>
            <th class="c">Email</th>
            <th class="c"><{$smarty.const._MA_TADUSERS_PASSWD}></th>
            <th class="c"><{$smarty.const._MA_TADUSERS_GROUP}></th>
            <th class="c">bio</th>
            <th class="c"><{$smarty.const._TAD_FUNCTION}></th>
        </tr>
        <tr>
            <td class="c"><a href="<{$xoops_url}>/userinfo.php?uid=<{$uid}>"><{$uid}></a></td>
            <td class="c"><a href="<{$xoops_url}>/userinfo.php?uid=<{$uid}>"><{$name}></a></td>
            <td class="c"><a href="<{$xoops_url}>/userinfo.php?uid=<{$uid}>"><{$uname}></a></td>
            <td class="c"><{$email}></td>
            <td class="c"><input type="text" name="pass" id="pass" class="form-control " title="要改<{$smarty.const._MA_TADUSERS_PASSWD}>才需填寫" data-toggle="tooltip"></td>
            <td class="c"><{$XoopsFormSelectGroup}></td>
            <td class="c"><input type="text" name="bio" id="bio" class="form-control " value="<{$bio}>"></td>
            <td class="c">
                <input type="hidden" name="op" value="update_user">
                <input type="hidden" name="uid" value="<{$uid}>">
                <input type="hidden" name="g2p" value="<{$smarty.get.g2p}>">
                <button type="submit" class="btn btn-primary"><{$smarty.const._TAD_SUBMIT}></button>
            </td>
        </tr>
    </table>
</form>