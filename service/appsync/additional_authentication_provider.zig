const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const LambdaAuthorizerConfig = @import("lambda_authorizer_config.zig").LambdaAuthorizerConfig;
const OpenIDConnectConfig = @import("open_id_connect_config.zig").OpenIDConnectConfig;
const CognitoUserPoolConfig = @import("cognito_user_pool_config.zig").CognitoUserPoolConfig;

/// Describes an additional authentication provider.
pub const AdditionalAuthenticationProvider = struct {
    /// The authentication type: API key, Identity and Access Management (IAM),
    /// OpenID
    /// Connect (OIDC), Amazon Cognito user pools, or Lambda.
    authentication_type: ?AuthenticationType,

    /// Configuration for Lambda function authorization.
    lambda_authorizer_config: ?LambdaAuthorizerConfig,

    /// The OIDC configuration.
    open_id_connect_config: ?OpenIDConnectConfig,

    /// The Amazon Cognito user pool configuration.
    user_pool_config: ?CognitoUserPoolConfig,

    pub const json_field_names = .{
        .authentication_type = "authenticationType",
        .lambda_authorizer_config = "lambdaAuthorizerConfig",
        .open_id_connect_config = "openIDConnectConfig",
        .user_pool_config = "userPoolConfig",
    };
};
