pub const PrefixListState = enum {
    create_in_progress,
    create_complete,
    create_failed,
    modify_in_progress,
    modify_complete,
    modify_failed,
    restore_in_progress,
    restore_complete,
    restore_failed,
    delete_in_progress,
    delete_complete,
    delete_failed,
};
