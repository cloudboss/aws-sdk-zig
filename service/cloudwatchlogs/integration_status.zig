pub const IntegrationStatus = enum {
    provisioning,
    active,
    failed,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};
