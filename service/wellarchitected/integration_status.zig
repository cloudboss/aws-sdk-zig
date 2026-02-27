pub const IntegrationStatus = enum {
    configured,
    not_configured,

    pub const json_field_names = .{
        .configured = "CONFIGURED",
        .not_configured = "NOT_CONFIGURED",
    };
};
