<h1 class="my"><{$smarty.const._MA_TADUSERS_LIST}></h1>
<style>
    .footable th{
        color:black;
    }
</style>
<{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_search_bar.tpl"}>

<{$Bootstrap3EditableCode}>
<div class="table-responsive">
    <table class="table table-hover table-striped footable">
        <thead>
            <tr>
                <th class="c" data-hide="phone,tablet"><{$smarty.const._MA_TADUSERS_DEL}></th>
                <th class="c">uid</th>
                <th class="c" data-class="expand"><{$smarty.const._MA_TADUSERS_NAME}></th>
                <th class="c"><{$smarty.const._MA_TADUSERS_UNAME}></th>
                <th class="c" data-hide="phone">Email</th>
                <th class="c n" data-hide="phone"><{$smarty.const._MA_TADUSERS_TIMEZONE}></th>
                <th class="c" data-hide="phone,tablet"><{$smarty.const._MA_TADUSERS_LASTLOGIN}></th>
                <th class="c" data-hide="phone,tablet" data-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_ICQ}>">icq</th>
                <th class="c" data-hide="phone,tablet"><{$smarty.const._MA_TADUSERS_THEME}></th>
                <!-- <th class="c" data-toggle="tooltip" title="user_msnm <{$smarty.const._MA_TADUSERS_COL}>">msnm</th> -->
                <th class="c" data-hide="phone" data-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_OCC}>">occ</th>
                <th class="c" data-hide="phone" data-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_INTREST}>">intrest</th>
                <th class="c" data-hide="phone,tablet" style="min-width: 300px;" data-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_BIO}>">bio</th>
                <th class="c"><{$smarty.const._TAD_FUNCTION}></th>
            </tr>
        </thead>
        <{foreach from=$users item=user}>
            <tr>
                <td class="c">
                    <a href="<{$xoops_url}>/modules/system/admin.php?fct=users&op=users_delete&uid=<{$user.uid}>" target="_blank" class="btn btn-danger btn-sm btn-xs"><{$smarty.const._MA_TADUSERS_DEL}></a>
                </td>
                <td class="c n">
                    <a href="<{$xoops_url}>/userinfo.php?uid=<{$user.uid}>"><{$user.uid}></a>
                </td>
                <td class="c n editable" data-name="name" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value'}">
                    <{$user.name}>
                    <{if $user.actkey == "tadusers"}><img src="../images/people.png" alt="<{$smarty.const._MA_TADUSERS_FROM_SYS}>"  data-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_FROM_SYS}>"><{/if}>
                </td>
                <td class="c n">
                    <a href="<{$xoops_url}>/userinfo.php?uid=<{$user.uid}>"><{$user.uname}></a>
                </td>
                <td class="c n editable" data-name="email" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value'}">
                    <{$user.email}>
                </td>
                <td class="c n editable" data-name="timezone_offset" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value'}">
                    <{$user.timezone_offset}>
                </td>
                <td class="c n">
                    <{$user.last_login}>
                </td>
                <td class="c n editable" data-name="user_icq" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value'}">
                    <{$user.user_icq}>
                </td>
                <td class="c n editable" data-name="theme" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value'}"><{$user.theme}></td>
                <!-- <td class="c n"><{$user.user_msnm}></td> -->
                <td class="c n editable" data-name="user_occ" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value'}">
                    <{$user.user_occ}>
                </td>
                <td class="c n editable" data-name="user_intrest" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value'}">
                    <{$user.user_intrest}>
                </td>
                <td class="c">
                    <{$user.bio}>
                </td>
                <td class="c n">
                    <a href="main.php?op=edit_users&uid=<{$user.uid}>&g2p=<{$smarty.get.g2p}>" class="btn btn-warning btn-sm btn-xs"><{$smarty.const._MA_TADUSERS_EDIT}></a>
                </td>
            </tr>
        <{/foreach}>
    </table>
</div>

<{$bar}>