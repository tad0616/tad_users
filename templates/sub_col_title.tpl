
<a href="main.php?groupid=<{$groupid}>&key=<{$key}>&desc=<{$desc}>&sort=<{$col}>">
<{$col_title}>
<{if $sort==$col}>
    <{if $desc=='desc'}>
        <i class="fa fa-caret-down" aria-hidden="true"></i>
    <{else}>
        <i class="fa fa-caret-up" aria-hidden="true"></i>
    <{/if}>
<{/if}>
</a>
