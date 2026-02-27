pub const BrandVersionStatus = enum {
    create_in_progress,
    create_succeeded,
    create_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_succeeded = "CREATE_SUCCEEDED",
        .create_failed = "CREATE_FAILED",
    };
};
