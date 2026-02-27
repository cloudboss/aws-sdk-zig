pub const QuickResponseStatus = enum {
    create_in_progress,
    create_failed,
    created,
    delete_in_progress,
    delete_failed,
    deleted,
    update_in_progress,
    update_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .created = "CREATED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
    };
};
