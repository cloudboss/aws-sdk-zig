pub const ConfigurationState = enum {
    enabled,
    update_in_progress,
    update_failed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
    };
};
