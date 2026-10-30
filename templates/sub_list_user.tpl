<form action="main.php" method="post" id="myForm" class="myForm">
    <{include file="$xoops_rootpath/modules/tad_users/templates/sub_search_bar.tpl"}>
    <{if $users|default:false}>
        <div class="table-responsive">
            <table id="users_table"
                class="table table-hover table-striped"
                data-toggle="table"
                data-search="true"
                data-show-search-clear-button="true"
                data-mobile-responsive="true"
                data-id-field="uid"
                data-editable-url="<{$xoops_url}>/modules/tad_users/admin/ajax.php"
                data-editable-params="{op:'update_value'}">
                <thead>
                    <tr>
                        <th class="c n" data-field="del"><{$smarty.const._MA_TADUSERS_DEL}></th>
                        <th class="c n" data-field="chk">
                            <input type="checkbox" id="clickAll">
                        </th>
                        <th class="c n" data-field="uid" data-sortable="true">uid</th>
                        <th class="c n" data-field="name" data-sortable="true" data-editable="true"><{$smarty.const._MA_TADUSERS_NAME}></th>
                        <th class="c n" data-field="uname" data-sortable="true"><{$smarty.const._MA_TADUSERS_UNAME}></th>
                        <th class="c n" data-field="email" data-sortable="true" data-editable="true">Email</th>
                        <th class="c n" data-field="func"><{$smarty.const._TAD_FUNCTION}></th>
                        <th class="c n" data-field="timezone_offset" data-sortable="true" data-editable="true"><{$smarty.const._MA_TADUSERS_TIMEZONE}></th>
                        <th class="c n" data-field="theme" data-sortable="true" data-editable="true"><{$smarty.const._MA_TADUSERS_THEME}></th>
                        <th class="c n" data-field="last_login" data-sortable="true"><{$smarty.const._MA_TADUSERS_LASTLOGIN}></th>
                        <th class="c n" data-field="user_icq" data-sortable="true" data-editable="true" title="<{$smarty.const._MA_TADUSERS_ICQ}>">icq</th>
                        <th class="c n" data-field="user_occ" data-sortable="true" data-editable="true" title="<{$smarty.const._MA_TADUSERS_OCC}>">occ</th>
                        <th class="c n" data-field="user_intrest" data-sortable="true" data-editable="true" title="<{$smarty.const._MA_TADUSERS_INTREST}>">intrest</th>
                        <{if $mode=='ng'}>
                            <th class="c n" data-field="ng" style="min-width: 300px;" title="<{$smarty.const._MA_TADUSERS_NG}>">ng</th>
                        <{else}>
                            <th class="c n" data-field="bio" data-sortable="true" style="min-width: 300px;" title="<{$smarty.const._MA_TADUSERS_BIO}>">bio</th>
                        <{/if}>
                    </tr>
                </thead>
                <tbody>
                <{foreach from=$users item=user}>
                    <tr>
                        <td class="c">
                            <a href="<{$xoops_url}>/modules/system/admin.php?fct=users&op=users_delete&uid=<{$user.uid}>" target="_blank" class="btn btn-danger btn-sm btn-xs"><{$smarty.const._MA_TADUSERS_DEL}></a>
                        </td>
                        <td class="c n">
                            <input class="form-check-input uid" type="checkbox" name="uid_arr[]" value="<{$user.uid}>">
                        </td>
                        <td class="c n"><{$user.uid}></td>
                        <td class="c n"><{$user.name}></td>
                        <td class="c n">
                            <a href="<{$xoops_url}>/modules/system/admin.php?fct=users&op=users_edit&uid=<{$user.uid}>">
                            <{$user.uname}>
                            </a>
                            <{if $user.actkey == "tadusers"}><img src="../images/people.png" alt="<{$smarty.const._MA_TADUSERS_FROM_SYS}>"  data-toggle="tooltip" data-bs-toggle="tooltip" title="<{$smarty.const._MA_TADUSERS_FROM_SYS}>"><{/if}>
                        </td>
                        <td class="c n"><{$user.email}></td>
                        <td class="c n">
                            <a href="main.php?op=edit_users&uid=<{$user.uid}>&g2p=<{$smarty.get.g2p|intval}>" class="btn btn-warning btn-sm btn-xs" data-toggle="tooltip" data-bs-toggle="tooltip" data-html="true" data-bs-html="true" title="<{$user.groups}>"><{$smarty.const._MA_TADUSERS_EDIT}></a>
                        </td>
                        <td class="c n"><{$user.timezone_offset}></td>
                        <td class="c n"><{$user.theme}></td>
                        <td class="c n"><{$user.last_login}></td>
                        <td class="c n"><{$user.user_icq}></td>
                        <td class="c n"><{$user.user_occ}></td>
                        <td class="c n"><{$user.user_intrest}></td>

                        <td class="c">
                        <{if $mode=='ng'}>
                            <{foreach from=$user.ng item=ng}>
                                <li class="text-danger"><{$ng|default:''}></li>
                            <{/foreach}>
                        <{else}>
                            <span <{if $user.bio_list|default:false}> data-toggle="tooltip" data-bs-toggle="tooltip" data-html="true" data-bs-html="true" title="<{$user.bio_list}>"<{/if}>><{$user.bio}></span>
                        <{/if}>
                        </td>
                    </tr>
                <{/foreach}>
                </tbody>
            </table>
        </div>
        <{$token_form|default:''}>
    <{elseif $mode=="ng"}>
        <div class="alert alert-success">
            <h3><{$group_array.$groupid}><{$smarty.const._MA_TADUSERS_ALL_OK}></h3>
        </div>
    <{/if}>

</form>

<script type='text/javascript'>
    $().ready(function(){
        $("#op1").on('change', function(){
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
