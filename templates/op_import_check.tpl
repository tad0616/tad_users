<h1 class="my"><{$smarty.const._MA_TADUSERS_CHKID}></h1>

<form action="import.php" method="post">
	<table class="table table-sm table-condensed">
    <tr class="bg-info white">
        <th><{$smarty.const._MA_TADUSERS_ID}></th>
        <th><{$smarty.const._MA_TADUSERS_NAME}></th>
        <th>Email</th><th><{$smarty.const._MA_TADUSERS_PASS}></th>
        <th><{$smarty.const._MA_TADUSERS_ID_CHK}></th>
    </tr>

    <{foreach from=$users key=i item=user}>
        <{if $user.id_existed}>
            <tr class="bg-white">
                <td><{$user.uname}></td>
                <td><{$user.name}></td>
                <td><{$user.email}></td>
                <td><{$user.passwd}></td>
                <td><{$smarty.const._MA_TADUSERS_ID_EXIST}></td>
            </tr>
        <{else}>
            <tr class="bg-white">
                <td>
                    <{$user.uname}>
                    <input type="hidden" name="data[<{$i}>][uname]" value="<{$user.uname}>">
                </td>
                <td>
                    <{$user.name}>
                    <input type="hidden" name="data[<{$i}>][name]" value="<{$user.name}>">
                </td>
                <td>
                    <{$user.email}>
                    <input type="hidden" name="data[<{$i}>][email]" value="<{$user.email}>">
                </td>
                <td>
                    <{$user.passwd}>
                    <input type="hidden" name="data[<{$i}>][passwd]" value="<{$user.passwd}>">
                </td>
                <td>OK</td>
            </tr>
        <{/if}>
    <{/foreach}>
    
    <tr>
        <td colspan=2>
            <{$smarty.const._MA_TADUSERS_JOIN_GROUP}>
        </td>
        <td colspan=3>
            <{$group_select}>
        </td>
    </tr>
    </table>
    
	<button type="submit" class="btn btn-primary" name="op" value="add_user"><{$smarty.const._MA_TADUSERS_NEXT}></button>
</form>