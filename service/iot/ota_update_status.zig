pub const OTAUpdateStatus = enum {
    create_pending,
    create_in_progress,
    create_complete,
    create_failed,
    delete_in_progress,
    delete_failed,

    pub const json_field_names = .{
        .create_pending = "CREATE_PENDING",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_complete = "CREATE_COMPLETE",
        .create_failed = "CREATE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
    };
};
