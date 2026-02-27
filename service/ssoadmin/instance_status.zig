pub const InstanceStatus = enum {
    create_in_progress,
    create_failed,
    delete_in_progress,
    active,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .active = "ACTIVE",
    };
};
