pub const OrganizationConfigurationConfigurationType = enum {
    central,
    local,

    pub const json_field_names = .{
        .central = "CENTRAL",
        .local = "LOCAL",
    };
};
