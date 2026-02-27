pub const BrandStatus = enum {
    create_in_progress,
    create_succeeded,
    create_failed,
    delete_in_progress,
    delete_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_succeeded = "CREATE_SUCCEEDED",
        .create_failed = "CREATE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
    };
};
