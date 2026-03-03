const AuthenticationProviderTypes = @import("authentication_provider_types.zig").AuthenticationProviderTypes;
const SamlConfigurationStatus = @import("saml_configuration_status.zig").SamlConfigurationStatus;

/// A structure that describes whether the workspace uses SAML, IAM Identity
/// Center, or
/// both methods for user authentication, and whether that authentication is
/// fully
/// configured.
pub const AuthenticationSummary = struct {
    /// Specifies whether the workspace uses SAML, IAM Identity Center, or both
    /// methods for
    /// user authentication.
    providers: []const AuthenticationProviderTypes,

    /// Specifies whether the workplace's user authentication method is fully
    /// configured.
    saml_configuration_status: ?SamlConfigurationStatus = null,

    pub const json_field_names = .{
        .providers = "providers",
        .saml_configuration_status = "samlConfigurationStatus",
    };
};
