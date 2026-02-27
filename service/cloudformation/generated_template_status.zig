pub const GeneratedTemplateStatus = enum {
    create_pending,
    update_pending,
    delete_pending,
    create_in_progress,
    update_in_progress,
    delete_in_progress,
    failed,
    complete,
};
