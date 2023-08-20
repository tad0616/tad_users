<{$Bootstrap3EditableCode}>
<style>
    .footable th{
        color:black;
    }
</style>
<form action="main.php" method="post" id="myForm" class="myForm">
    <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_search_bar.tpl"}>
    <{if $users}>
        <div class="table-responsive">
            <table class="table table-hover table-striped footable">
                <thead>
                    <tr>
                        <th class="c n" data-hide="phone,tablet"><{$smarty.const._MA_TADUSERS_DEL}></th>
                        <th class="c n">
                            <input type="checkbox" id="clickAll">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="uid" col_title="uid"}>
                        </th>
                        <th class="c n" data-class="expand">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="name" col_title=$smarty.const._MA_TADUSERS_NAME}>
                        </th>
                        <th class="c n">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="uname" col_title=$smarty.const._MA_TADUSERS_UNAME}>
                        </th>
                        <th class="c n" data-hide="phone">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="email" col_title="Email"}>
                        </th>
                        <th class="c n"><{$smarty.const._TAD_FUNCTION}></th>
                        <th class="c n" data-hide="phone">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="timezone_offset" col_title=$smarty.const._MA_TADUSERS_TIMEZONE}>
                        </th>
                        <th class="c n" data-hide="phone,tablet">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="theme" col_title=$smarty.const._MA_TADUSERS_THEME}>
                        </th>
                        <th class="c n" data-hide="phone,tablet">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="last_login" col_title=$smarty.const._MA_TADUSERS_LASTLOGIN}>
                        </th>
                        <th class="c n" data-hide="phone,tablet" data-toggle="tooltip" data-bs-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_ICQ}>">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="user_icq" col_title="icq"}>
                        </th>
                        <th class="c n" data-hide="phone" data-toggle="tooltip" data-bs-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_OCC}>">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="user_occ" col_title="occ"}>
                        </th>
                        <th class="c n" data-hide="phone" data-toggle="tooltip" data-bs-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_INTREST}>">
                            <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="user_intrest" col_title="intrest"}>
                        </th>
                        <{if $mode=='ng'}>
                            <th class="c n" data-hide="phone,tablet" style="min-width: 300px;" data-toggle="tooltip" data-bs-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_NG}>">
                                <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="ng" col_title="ng"}>
                            </th>
                        <{else}>
                            <th class="c n" data-hide="phone,tablet" style="min-width: 300px;" data-toggle="tooltip" data-bs-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_BIO}>">
                                <{includeq file="$xoops_rootpath/modules/tad_users/templates/sub_col_title.tpl" col="bio" col_title="bio"}>
                            </th>
                        <{/if}>
                    </tr>
                </thead>
                <{foreach from=$users item=user}>
                    <tr>
                        <td class="c">
                            <a href="<{$xoops_url}>/modules/system/admin.php?fct=users&op=users_delete&uid=<{$user.uid}>" target="_blank" class="btn btn-danger btn-sm btn-xs"><{$smarty.const._MA_TADUSERS_DEL}></a>
                        </td>
                        <td class="c n">
                            <div class="form-check-inline checkbox-inline">
                                <label class="form-check-label">
                                    <input class="form-check-input uid" type="checkbox" name="uid_arr[]" value="<{$user.uid}>">
                                    <{$user.uid}>
                                </label>
                            </div>
                        </td>
                        <td class="c n editable" data-name="name" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value', uid:'<{$user.uid}>'}">
                            <{$user.name}>
                            <{if $user.actkey == "tadusers"}><img src="../images/people.png" alt="<{$smarty.const._MA_TADUSERS_FROM_SYS}>"  data-toggle="tooltip" data-bs-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_FROM_SYS}>"><{/if}>
                        </td>
                        <td class="c n">
                            <a href="<{$xoops_url}>/modules/system/admin.php?fct=users&op=users_edit&uid=<{$user.uid}>">
                            <{$user.uname}>
                            </a>
                        </td>
                        <td class="c n editable" data-name="email" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value', uid:'<{$user.uid}>'}">
                            <{$user.email}>
                        </td>
                        <td class="c n">

                            <a href="main.php?op=edit_users&uid=<{$user.uid}>&g2p=<{$smarty.get.g2p}>" class="btn btn-warning btn-sm btn-xs" data-toggle="tooltip" data-bs-toggle="tooltip" data-html="true" data-bs-html="true" title="<{$user.groups}>"><{$smarty.const._MA_TADUSERS_EDIT}></a>
                        </td>
                        <td class="c n editable" data-name="timezone_offset" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value', uid:'<{$user.uid}>'}">
                            <{$user.timezone_offset}>
                        </td>
                        <td class="c n editable" data-name="theme" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value', uid:'<{$user.uid}>'}"><{$user.theme}></td>
                        <td class="c n">
                            <{$user.last_login}>
                        </td>
                        <td class="c n editable" data-name="user_icq" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value', uid:'<{$user.uid}>'}">
                            <{$user.user_icq}>
                        </td>
                        <td class="c n editable" data-name="user_occ" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value', uid:'<{$user.uid}>'}">
                            <{$user.user_occ}>
                        </td>
                        <td class="c n editable" data-name="user_intrest" data-type="text" data-pk="<{$user.uid}>" data-params="{op: 'update_value', uid:'<{$user.uid}>'}">
                            <{$user.user_intrest}>
                        </td>

                        <td class="c">
                        <{if $mode=='ng'}>
                            <{foreach from=$user.ng item=ng}>
                                <li class="text-danger"><{$ng}></li>
                            <{/foreach}>
                        <{else}>
                            <span <{if $user.bio_list}> data-toggle="tooltip" data-bs-toggle="tooltip" data-html="true" data-bs-html="true" title="<{$user.bio_list}>"<{/if}>><{$user.bio}></span>
                        <{/if}>
                        </td>
                    </tr>
                <{/foreach}>
            </table>
        </div>
        <{$token_form}>
    <{elseif $mode=="ng"}>
        <div class="alert alert-success">
            <h3><{$group_array.$groupid}><{$smarty.const._MA_TADUSERS_ALL_OK}></h3>
        </div>
    <{/if}>

</form>

<script type='text/javascript'>
    $().ready(function(){
        $("#op1").change(function(){
            var op1 = $("#op1").val();
            if(op1 == 'add_group' || op1=='del_group'){
                $('.group_select').show();
                $('.val_input').hide();
            }else{
                $('.group_select').hide();
                $('.val_input').show();
            }
        });

        $("#clickAll").click(function() {
            var x = document.getElementById("clickAll").checked;
            if(x){
                $(".uid").each(function() {
                    $(this).attr("checked", true);
                });
            }else{
                $(".uid").each(function() {
                        $(this).attr("checked", false);
                });
            }
        });

    });
</script>
