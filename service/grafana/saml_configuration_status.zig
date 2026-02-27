pub const SamlConfigurationStatus = enum {
    /// Indicates that SAML on an AMG workspace is enabled and has been configured.
    configured,
    /// Indicates that SAML on an AMG workspace is enabled but has not been
    /// configured.
    not_configured,

    pub const json_field_names = .{
        .configured = "CONFIGURED",
        .not_configured = "NOT_CONFIGURED",
    };
};
