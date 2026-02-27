pub const DelegatedAdminStatus = enum {
    enabled,
    disable_in_progress,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disable_in_progress = "DISABLE_IN_PROGRESS",
    };
};
