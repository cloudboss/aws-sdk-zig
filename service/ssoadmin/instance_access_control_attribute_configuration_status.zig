pub const InstanceAccessControlAttributeConfigurationStatus = enum {
    enabled,
    creation_in_progress,
    creation_failed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .creation_failed = "CREATION_FAILED",
    };
};
