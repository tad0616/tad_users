<h1 class="my"><{$smarty.const._MA_TADUSERS_CHKID}></h1>
	<form action="add.php" method="post">

	<p><b><{$smarty.const._MA_TADUSERS_COPY|sprintf:"csv.php?f=$file_name"}></b></p>

	<table class="table table-bordered table-hover table-condensed table-sm">
	<tr><th><{$smarty.const._MA_TADUSERS_ID}></th><th><{$smarty.const._MA_TADUSERS_PASS}></th><th><{$smarty.const._MA_TADUSERS_ID_CHK}></th></tr>

    <{foreach from=$accounts key=i item=acc}>
        <{if $acc.id_existed}>
            <tr class="bg-white">
                <td><{$acc.id}></td><td><{$acc.passwd}></td><td><{$smarty.const._MA_TADUSERS_ID_EXIST}></td>
            </tr>
        <{else}>
            <tr>
                <td><{$acc.id}>
                    <input type="hidden" name="data[<{$i}>][id]" value="<{$acc.id}>">
                    <input type="hidden" name="data[<{$i}>][name]" value="<{$acc.id}>">
                </td>
                <td><{$acc.passwd}>
                    <input type="hidden" name="data[<{$i}>][passwd]" value="<{$acc.passwd}>">
                    <input type="hidden" name="data[<{$i}>][from]" value="our_member">
                </td><td>OK</td>
            </tr>
        <{/if}>
    <{/foreach}>

    </table><br>
	<input type="hidden" name="op" value="add_user">
	<input type="hidden" name="groupid" value="<{$data.groupid}>">
	<input type="submit" value="<{$smarty.const._MA_TADUSERS_NEXT}>">
	</form>