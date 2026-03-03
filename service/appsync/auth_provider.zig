const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const CognitoConfig = @import("cognito_config.zig").CognitoConfig;
const LambdaAuthorizerConfig = @import("lambda_authorizer_config.zig").LambdaAuthorizerConfig;
const OpenIDConnectConfig = @import("open_id_connect_config.zig").OpenIDConnectConfig;

/// Describes an authorization provider.
pub const AuthProvider = struct {
    /// The authorization type.
    auth_type: AuthenticationType,

    /// Describes an Amazon Cognito user pool configuration.
    cognito_config: ?CognitoConfig = null,

    lambda_authorizer_config: ?LambdaAuthorizerConfig = null,

    open_id_connect_config: ?OpenIDConnectConfig = null,

    pub const json_field_names = .{
        .auth_type = "authType",
        .cognito_config = "cognitoConfig",
        .lambda_authorizer_config = "lambdaAuthorizerConfig",
        .open_id_connect_config = "openIDConnectConfig",
    };
};
