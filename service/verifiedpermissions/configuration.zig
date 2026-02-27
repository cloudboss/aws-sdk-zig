const CognitoUserPoolConfiguration = @import("cognito_user_pool_configuration.zig").CognitoUserPoolConfiguration;
const OpenIdConnectConfiguration = @import("open_id_connect_configuration.zig").OpenIdConnectConfiguration;

/// Contains configuration information used when creating a new identity source.
///
/// This data type is used as a request parameter for the
/// [CreateIdentitySource](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreateIdentitySource.html) operation.
pub const Configuration = union(enum) {
    /// Contains configuration details of a Amazon Cognito user pool that Verified
    /// Permissions can use as a source of authenticated identities as entities. It
    /// specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of a Amazon Cognito user pool and one or more application client IDs.
    ///
    /// Example:
    /// `"configuration":{"cognitoUserPoolConfiguration":{"userPoolArn":"arn:aws:cognito-idp:us-east-1:123456789012:userpool/us-east-1_1a2b3c4d5","clientIds": ["a1b2c3d4e5f6g7h8i9j0kalbmc"],"groupConfiguration": {"groupEntityType": "MyCorp::Group"}}}`
    cognito_user_pool_configuration: ?CognitoUserPoolConfiguration,
    /// Contains configuration details of an OpenID Connect (OIDC) identity
    /// provider, or identity source, that Verified Permissions can use to generate
    /// entities from authenticated identities. It specifies the issuer URL, token
    /// type that you want to use, and policy store entity details.
    ///
    /// Example:`"configuration":{"openIdConnectConfiguration":{"issuer":"https://auth.example.com","tokenSelection":{"accessTokenOnly":{"audiences":["https://myapp.example.com","https://myapp2.example.com"],"principalIdClaim":"sub"}},"entityIdPrefix":"MyOIDCProvider","groupConfiguration":{"groupClaim":"groups","groupEntityType":"MyCorp::UserGroup"}}}`
    open_id_connect_configuration: ?OpenIdConnectConfiguration,

    pub const json_field_names = .{
        .cognito_user_pool_configuration = "cognitoUserPoolConfiguration",
        .open_id_connect_configuration = "openIdConnectConfiguration",
    };
};
