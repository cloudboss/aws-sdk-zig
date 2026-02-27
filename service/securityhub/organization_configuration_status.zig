pub const OrganizationConfigurationStatus = enum {
    pending,
    enabled,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .enabled = "ENABLED",
        .failed = "FAILED",
    };
};
