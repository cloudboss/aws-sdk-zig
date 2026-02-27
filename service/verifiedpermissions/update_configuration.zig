const UpdateCognitoUserPoolConfiguration = @import("update_cognito_user_pool_configuration.zig").UpdateCognitoUserPoolConfiguration;
const UpdateOpenIdConnectConfiguration = @import("update_open_id_connect_configuration.zig").UpdateOpenIdConnectConfiguration;

/// Contains an update to replace the configuration in an existing identity
/// source.
pub const UpdateConfiguration = union(enum) {
    /// Contains configuration details of a Amazon Cognito user pool.
    cognito_user_pool_configuration: ?UpdateCognitoUserPoolConfiguration,
    /// Contains configuration details of an OpenID Connect (OIDC) identity
    /// provider, or identity source, that Verified Permissions can use to generate
    /// entities from authenticated identities. It specifies the issuer URL, token
    /// type that you want to use, and policy store entity details.
    open_id_connect_configuration: ?UpdateOpenIdConnectConfiguration,

    pub const json_field_names = .{
        .cognito_user_pool_configuration = "cognitoUserPoolConfiguration",
        .open_id_connect_configuration = "openIdConnectConfiguration",
    };
};
