const AwsAppSyncGraphQlApiLambdaAuthorizerConfigDetails = @import("aws_app_sync_graph_ql_api_lambda_authorizer_config_details.zig").AwsAppSyncGraphQlApiLambdaAuthorizerConfigDetails;
const AwsAppSyncGraphQlApiOpenIdConnectConfigDetails = @import("aws_app_sync_graph_ql_api_open_id_connect_config_details.zig").AwsAppSyncGraphQlApiOpenIdConnectConfigDetails;
const AwsAppSyncGraphQlApiUserPoolConfigDetails = @import("aws_app_sync_graph_ql_api_user_pool_config_details.zig").AwsAppSyncGraphQlApiUserPoolConfigDetails;

/// A list of additional authentication providers for the GraphqlApi API.
pub const AwsAppSyncGraphQlApiAdditionalAuthenticationProvidersDetails = struct {
    /// The type of security configuration for your GraphQL API: API key, Identity
    /// and Access Management (IAM), OpenID Connect (OIDC), Amazon Cognito user
    /// pools, or Lambda.
    authentication_type: ?[]const u8 = null,

    /// The configuration for Lambda function authorization.
    lambda_authorizer_config: ?AwsAppSyncGraphQlApiLambdaAuthorizerConfigDetails = null,

    /// The OpenID Connect configuration.
    open_id_connect_config: ?AwsAppSyncGraphQlApiOpenIdConnectConfigDetails = null,

    /// The Amazon Cognito user pools configuration.
    user_pool_config: ?AwsAppSyncGraphQlApiUserPoolConfigDetails = null,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .lambda_authorizer_config = "LambdaAuthorizerConfig",
        .open_id_connect_config = "OpenIdConnectConfig",
        .user_pool_config = "UserPoolConfig",
    };
};
