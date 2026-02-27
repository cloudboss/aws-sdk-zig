const MasterUserOptions = @import("master_user_options.zig").MasterUserOptions;
const SAMLOptionsInput = @import("saml_options_input.zig").SAMLOptionsInput;

/// Specifies the advanced security configuration: whether advanced security is
/// enabled, whether the internal database option is enabled, master username
/// and password (if internal database is enabled), and master user ARN (if IAM
/// is enabled).
pub const AdvancedSecurityOptionsInput = struct {
    /// True if Anonymous auth is enabled. Anonymous auth can be enabled only when
    /// AdvancedSecurity is enabled on existing domains.
    anonymous_auth_enabled: ?bool,

    /// True if advanced security is enabled.
    enabled: ?bool,

    /// True if the internal user database is enabled.
    internal_user_database_enabled: ?bool,

    /// Credentials for the master user: username and password, ARN, or both.
    master_user_options: ?MasterUserOptions,

    /// Specifies the SAML application configuration for the domain.
    saml_options: ?SAMLOptionsInput,

    pub const json_field_names = .{
        .anonymous_auth_enabled = "AnonymousAuthEnabled",
        .enabled = "Enabled",
        .internal_user_database_enabled = "InternalUserDatabaseEnabled",
        .master_user_options = "MasterUserOptions",
        .saml_options = "SAMLOptions",
    };
};
