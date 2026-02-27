pub const ConfigurationState = enum {
    active,
    update_in_progress,
    update_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
    };
};
