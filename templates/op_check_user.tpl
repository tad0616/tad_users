<h1 class="my"><{$smarty.const._MA_TADUSERS_CHKID}></h1>

<form action="add.php" method="post">

	<table class="table table-bordered table-hover">
	    <tr>
            <th><{$smarty.const._MA_TADUSERS_ID}></th>
            <th><{$smarty.const._MA_TADUSERS_NAME}></th>
            <th><{$smarty.const._MA_TADUSERS_EMAIL}></th>
            <th><{$smarty.const._MA_TADUSERS_PASS}></th>
            <th><{$smarty.const._MA_TADUSERS_INTREST_COL}></th>
            <th><{$smarty.const._MA_TADUSERS_ID_CHK}></th>
        </tr>

        <{if $acc.id_existed|default:false}>
            <tr class="bg-white">
                <td><{$acc.id}></td>
                <td><{$acc.name}></td>
                <td><{$acc.email}></td>
                <td><{$acc.passwd}></td>
                <td><{$acc.intrest}></td>
                <td><{$smarty.const._MA_TADUSERS_ID_EXIST}></td>
            </tr>
        <{else}>
            <tr>
                <td>
                    <{$acc.id}>
                    <input type="hidden" name="data[0][id]" value="<{$acc.id}>">
                </td>
                <td>
                    <{$acc.name}>
                    <input type="hidden" name="data[0][name]" value="<{$acc.name}>">
                </td>
                <td>
                    <{$acc.email}>
                    <input type="hidden" name="data[0][email]" value="<{$acc.email}>">
                </td>
                <td>
                    <{$acc.passwd}>
                    <input type="hidden" name="data[0][passwd]" value="<{$acc.passwd}>">
                </td>
                <td>
                    <{$acc.intrest}>
                    <input type="hidden" name="data[0][intrest]" value="<{$acc.intrest}>">
                </td>
                <td>OK</td>
            </tr>
        <{/if}>


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
        <button type="submit" type="hidden" name="op" value="add_user" class="btn btn-primary"><{$smarty.const._MA_TADUSERS_ADD_USER}></button>
    </div>
</form>