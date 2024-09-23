
<a href="main.php?groupid=<{$groupid|default:''}>&key=<{$key|default:''}>&desc=<{$desc|default:''}>&sort=<{$col|default:''}>">
<{$col_title|default:''}>
<{if $sort==$col}>
    <{if $desc=='desc'}>
        <i class="fa fa-caret-down" aria-hidden="true"></i>
    <{else}>
        <i class="fa fa-caret-up" aria-hidden="true"></i>
    <{/if}>
<{/if}>
</a>
