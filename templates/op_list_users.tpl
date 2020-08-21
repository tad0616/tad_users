<h1 class="my"><{$smarty.const._MA_TADUSERS_LIST}></h1>

<{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_search_bar.tpl"}>

<!-- 上標下格 -->
<div class="vtable">
    <ul class="vhead">
        <li class="w025"><{$smarty.const._MA_TADUSERS_DEL}></li>
        <li class="w05">uid</li>
        <li class="w1"><{$smarty.const._MA_TADUSERS_NAME}></li>
        <li class="w05"><{$smarty.const._MA_TADUSERS_UNAME}></li>
        <li class="w1">Email</li>
        <li class="w05"><{$smarty.const._MA_TADUSERS_TIMEZONE}></li>
        <li class="w1"><{$smarty.const._MA_TADUSERS_LASTLOGIN}></li>
        <li class="w1"><{$smarty.const._MA_TADUSERS_UNAME}><{$smarty.const._MA_TADUSERS_FROM}></li>
        <li class="w05" data-toggle="tooltip" title="user_yim <{$smarty.const._MA_TADUSERS_COL}>">yim</li>
        <li class="w05" data-toggle="tooltip" title="user_msnm <{$smarty.const._MA_TADUSERS_COL}>">msnm</li>
        <li class="w05" data-toggle="tooltip" title="user_occ <{$smarty.const._MA_TADUSERS_COL}>">occ</li>
        <li class="w05" data-toggle="tooltip" title="user_intrest <{$smarty.const._MA_TADUSERS_COL}>">intrest</li>
        <li class="w1">bio</li>
        <li class="w05"><{$smarty.const._TAD_FUNCTION}></li>
    </ul>
    <{foreach from=$users item=user}>
        <ul>
            <li class="vcell"><{$smarty.const._MA_TADUSERS_DEL}></li>
            <li class="vm w025 c"><a href="<{$xoops_url}>/modules/system/admin.php?fct=users&op=users_delete&uid=<{$user.uid}>" target="_blank" class="btn btn-danger btn-sm btn-xs"><{$smarty.const._MA_TADUSERS_DEL}></a></li>
            <li class="vcell">uid</li>
            <li class="vm w05 c"><a href="<{$xoops_url}>/userinfo.php?uid=<{$user.uid}>"><{$user.uid}></a></li>
            <li class="vcell"><{$smarty.const._MA_TADUSERS_NAME}></li>
            <li class="vm w1 c"><{$user.name}></li>
            <li class="vcell"><{$smarty.const._MA_TADUSERS_UNAME}></li>
            <li class="vm w05 c"><a href="<{$xoops_url}>/userinfo.php?uid=<{$user.uid}>"><{$user.uname}></a></li>
            <li class="vcell">Email</li>
            <li class="vm w1 c"><{$user.email}></li>
            <li class="vcell"><{$smarty.const._MA_TADUSERS_TIMEZONE}></li>
            <li class="vm w05 c"><{$user.timezone_offset}></li>
            <li class="vcell"><{$smarty.const._MA_TADUSERS_LASTLOGIN}></li>
            <li class="vm w1 c"><{$user.last_login}></li>
            <li class="vcell"><{$smarty.const._MA_TADUSERS_UNAME}><{$smarty.const._MA_TADUSERS_FROM}></li>
            <li class="vm w1 c"><{if $user.actkey == "tadusers"}><{$smarty.const._MA_TADUSERS_FROM_SYS}><{else}><{$smarty.const._MA_TADUSERS_FROM_USER}><{/if}></li>
            <li class="vcell">user_yim</li>
            <li class="vm w05 c"><{$user.user_yim}></li>
            <li class="vcell">user_msnm</li>
            <li class="vm w05 c"><{$user.user_msnm}></li>
            <li class="vcell">user_occ</li>
            <li class="vm w05 c"><{$user.user_occ}></li>
            <li class="vcell">user_intrest</li>
            <li class="vm w05 c"><{$user.user_intrest}></li>
            <li class="vcell">bio</li>
            <li class="vm w05 c"><{$user.bio}></li>
            <li class="vcell"><{$smarty.const._TAD_FUNCTION}></li>
            <li class="vm w05 c"><a href="main.php?op=edit_users&uid=<{$user.uid}>&g2p=<{$smarty.get.g2p}>" class="btn btn-warning btn-sm btn-xs"><{$smarty.const._TAD_EDIT}></a></li>
        </ul>
    <{/foreach}>
</div>

<{$bar}>