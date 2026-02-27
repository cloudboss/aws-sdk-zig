/// Configuration information for Organizations.
pub const OrganizationConfiguration = struct {
    /// Enables Organizations integration.
    enable_integration: bool = false,

    pub const json_field_names = .{
        .enable_integration = "EnableIntegration",
    };
};
