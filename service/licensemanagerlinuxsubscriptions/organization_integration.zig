pub const OrganizationIntegration = enum {
    /// Enabled OrganizationIntegration
    enabled,
    /// Disabled OrganizationIntegration
    disabled,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .disabled = "Disabled",
    };
};
