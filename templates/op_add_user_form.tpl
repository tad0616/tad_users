<style>
    .add-user-card .card-body { padding: 1.25rem; }
    .add-user-card h2 {
        font-size: 1.25rem;
        margin: 0 0 1rem;
        padding-bottom: .75rem;
        border-bottom: 2px solid rgba(0, 0, 0, .08);
    }
    /* 標籤與欄位一律上下堆疊，在窄欄與手機上都不擠 */
    .add-user-card .form-group.row { margin-left: 0; margin-right: 0; }
    .add-user-card .form-group.row > [class*="col-"] {
        flex: 0 0 100%;
        max-width: 100%;
        width: 100%;
        padding-left: 0;
        padding-right: 0;
    }
    .add-user-card label.col-form-label {
        text-align: left !important;
        font-weight: 600;
        padding-bottom: .25rem;
    }
    .add-user-card select[multiple] { min-height: 7.5rem; }
    .add-user-card .input-group-text { white-space: normal; text-align: left; }
    .add-user-card .bar { margin-top: 1rem; }
    .add-user-card .bar .btn { width: 100%; }
    @media (min-width: 576px) {
        .add-user-card .bar .btn { width: auto; min-width: 10rem; }
    }
</style>

<div class="row">
    <div class="col-12 col-lg-6 col-xl-4 mb-4">
        <div class="card add-user-card h-100 shadow-sm">
            <div class="card-body">
                <{include file="$xoops_rootpath/modules/tad_users/templates/sub_create_id.tpl"}>
            </div>
        </div>
    </div>
    <div class="col-12 col-lg-6 col-xl-4 mb-4">
        <div class="card add-user-card h-100 shadow-sm">
            <div class="card-body">
                <{include file="$xoops_rootpath/modules/tad_users/templates/sub_create_id_batch.tpl"}>
            </div>
        </div>
    </div>
    <div class="col-12 col-xl-4 mb-4">
        <div class="card add-user-card h-100 shadow-sm">
            <div class="card-body">
                <{include file="$xoops_rootpath/modules/tad_users/templates/sub_import_form.tpl"}>
            </div>
        </div>
    </div>
</div>
