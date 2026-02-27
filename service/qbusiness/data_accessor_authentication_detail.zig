const DataAccessorAuthenticationConfiguration = @import("data_accessor_authentication_configuration.zig").DataAccessorAuthenticationConfiguration;
const DataAccessorAuthenticationType = @import("data_accessor_authentication_type.zig").DataAccessorAuthenticationType;

/// Contains the authentication configuration details for a data accessor. This
/// structure defines how the ISV authenticates when accessing data through the
/// data accessor.
pub const DataAccessorAuthenticationDetail = struct {
    /// The specific authentication configuration based on the authentication type.
    authentication_configuration: ?DataAccessorAuthenticationConfiguration,

    /// The type of authentication to use for the data accessor. This determines how
    /// the ISV authenticates when accessing data. You can use one of two
    /// authentication types:
    ///
    /// * `AWS_IAM_IDC_TTI` - Authentication using IAM Identity Center Trusted Token
    ///   Issuer (TTI). This authentication type allows the ISV to use a trusted
    ///   token issuer to generate tokens for accessing the data.
    /// * `AWS_IAM_IDC_AUTH_CODE` - Authentication using IAM Identity Center
    ///   authorization code flow. This authentication type uses the standard OAuth
    ///   2.0 authorization code flow for authentication.
    authentication_type: DataAccessorAuthenticationType,

    /// A list of external identifiers associated with this authentication
    /// configuration. These are used to correlate the data accessor with external
    /// systems.
    external_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .authentication_configuration = "authenticationConfiguration",
        .authentication_type = "authenticationType",
        .external_ids = "externalIds",
    };
};
