pub const IpamState = enum {
    create_in_progress,
    create_complete,
    create_failed,
    modify_in_progress,
    modify_complete,
    modify_failed,
    delete_in_progress,
    delete_complete,
    delete_failed,
    isolate_in_progress,
    isolate_complete,
    restore_in_progress,
};
