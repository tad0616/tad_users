<h1 class="my"><{$smarty.const._MA_TADUSERS_CHKID}></h1>

<form action="add.php" method="post">
	<table class="table  table-bordered table-hover">
    <tr class="bg-info white">
        <th><{$smarty.const._MA_TADUSERS_ID}></th>
        <th><{$smarty.const._MA_TADUSERS_NAME}></th>
        <th><{$smarty.const._MA_TADUSERS_EMAIL}></th>
        <th><{$smarty.const._MA_TADUSERS_PASS}></th>
        <th><{$smarty.const._MA_TADUSERS_INTREST_COL}></th>
        <th><{$smarty.const._MA_TADUSERS_ID_CHK}></th>
    </tr>

    <{foreach from=$users key=i item=user}>
        <{if $user.id_existed|default:false}>
            <tr class="bg-white">
                <td><{$user.uname}></td>
                <td><{$user.name}></td>
                <td><{$user.email}></td>
                <td><{$user.passwd}></td>
                <td><{$intrest|default:''}></td>
                <td><{$smarty.const._MA_TADUSERS_ID_EXIST}></td>
            </tr>
        <{else}>
            <tr class="bg-white">
                <td>
                    <{$user.uname}>
                    <input type="hidden" name="data[<{$i|default:''}>][uname]" value="<{$user.uname}>">
                </td>
                <td>
                    <{$user.name}>
                    <input type="hidden" name="data[<{$i|default:''}>][name]" value="<{$user.name}>">
                </td>
                <td>
                    <{$user.email}>
                    <input type="hidden" name="data[<{$i|default:''}>][email]" value="<{$user.email}>">
                </td>
                <td>
                    <{$user.passwd}>
                    <input type="hidden" name="data[<{$i|default:''}>][passwd]" value="<{$user.passwd}>">
                </td>
                <td>
                    <{$intrest|default:''}>
                    <input type="hidden" name="data[<{$i|default:''}>][intrest]" value="<{$intrest|default:''}>">
                </td>
                <td>OK</td>
            </tr>
        <{/if}>
    <{/foreach}>

    <tr class="bg-warning">
        <td colspan=2>
            <{$smarty.const._MA_TADUSERS_JOIN_GROUP}>
        </td>
        <td colspan=4>
            <{foreach from=$group_array key=groupid item=title name=group_array}>
                <input type="checkbox" name="groups[]" id="group_<{$groupid|default:''}>" value="<{$groupid|default:''}>" <{if $groups && ($groupid|in_array:$groups|| $groupid==2)}>checked<{/if}>>
                    <label for="group_<{$groupid|default:''}>"><{$title|default:''}></label>
            <{/foreach}>
        </td>
    </tr>
    </table>

    <div class="bar">
        <button type="submit" class="btn btn-primary" name="op" value="add_user"><{$smarty.const._MA_TADUSERS_ADD_USER}></button>
    </div>
</form>