pub const FleetStatus = enum {
    active,
    create_in_progress,
    update_in_progress,
    create_failed,
    update_failed,
    suspended,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .suspended = "SUSPENDED",
    };
};
