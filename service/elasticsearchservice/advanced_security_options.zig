const SAMLOptionsOutput = @import("saml_options_output.zig").SAMLOptionsOutput;

/// Specifies the advanced security configuration: whether advanced security is
/// enabled, whether the internal database option is enabled.
pub const AdvancedSecurityOptions = struct {
    /// Specifies the Anonymous Auth Disable Date when Anonymous Auth is enabled.
    anonymous_auth_disable_date: ?i64 = null,

    /// True if Anonymous auth is enabled. Anonymous auth can be enabled only when
    /// AdvancedSecurity is enabled on existing domains.
    anonymous_auth_enabled: ?bool = null,

    /// True if advanced security is enabled.
    enabled: ?bool = null,

    /// True if the internal user database is enabled.
    internal_user_database_enabled: ?bool = null,

    /// Describes the SAML application configured for a domain.
    saml_options: ?SAMLOptionsOutput = null,

    pub const json_field_names = .{
        .anonymous_auth_disable_date = "AnonymousAuthDisableDate",
        .anonymous_auth_enabled = "AnonymousAuthEnabled",
        .enabled = "Enabled",
        .internal_user_database_enabled = "InternalUserDatabaseEnabled",
        .saml_options = "SAMLOptions",
    };
};
