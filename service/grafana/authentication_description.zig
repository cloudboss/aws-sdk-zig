const AwsSsoAuthentication = @import("aws_sso_authentication.zig").AwsSsoAuthentication;
const AuthenticationProviderTypes = @import("authentication_provider_types.zig").AuthenticationProviderTypes;
const SamlAuthentication = @import("saml_authentication.zig").SamlAuthentication;

/// A structure containing information about the user authentication methods
/// used by the
/// workspace.
pub const AuthenticationDescription = struct {
    /// A structure containing information about how this workspace works with IAM
    /// Identity Center.
    aws_sso: ?AwsSsoAuthentication,

    /// Specifies whether this workspace uses IAM Identity Center, SAML, or both
    /// methods to
    /// authenticate users to use the Grafana console in the Amazon Managed Grafana
    /// workspace.
    providers: []const AuthenticationProviderTypes,

    /// A structure containing information about how this workspace works with SAML,
    /// including
    /// what attributes within the assertion are to be mapped to user information in
    /// the
    /// workspace.
    saml: ?SamlAuthentication,

    pub const json_field_names = .{
        .aws_sso = "awsSso",
        .providers = "providers",
        .saml = "saml",
    };
};
