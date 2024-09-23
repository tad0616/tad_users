<h1 class="my" title="<{$groupid|default:''}>"><{$group_array.$groupid}> <{$smarty.const._MA_TADUSERS_MEMBER_CHECK}></h1>
<{if $no_uid_members>0}>
    <a href="main.php?op=clear_uid0&groupid=<{$groupid|default:''}>" class="btn btn-warning my-2"><{$group_array.$groupid}> <{$smarty.const._MA_TADUSERS_MEMBER_CHECK_UID_0}><{$no_uid_members|default:''}> <{$smarty.const._MA_TADUSERS_CLEAR_UID_0}></a>

<{/if}>

<{include file="$xoops_rootpath/modules/tad_users/templates/sub_list_user.tpl" mode="ng"}>
