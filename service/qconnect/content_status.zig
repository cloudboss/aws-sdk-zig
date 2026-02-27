pub const ContentStatus = enum {
    create_in_progress,
    create_failed,
    active,
    delete_in_progress,
    delete_failed,
    deleted,
    update_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
        .update_failed = "UPDATE_FAILED",
    };
};
