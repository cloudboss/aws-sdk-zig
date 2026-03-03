const AwsAppSyncGraphQlApiAdditionalAuthenticationProvidersDetails = @import("aws_app_sync_graph_ql_api_additional_authentication_providers_details.zig").AwsAppSyncGraphQlApiAdditionalAuthenticationProvidersDetails;
const AwsAppSyncGraphQlApiLambdaAuthorizerConfigDetails = @import("aws_app_sync_graph_ql_api_lambda_authorizer_config_details.zig").AwsAppSyncGraphQlApiLambdaAuthorizerConfigDetails;
const AwsAppSyncGraphQlApiLogConfigDetails = @import("aws_app_sync_graph_ql_api_log_config_details.zig").AwsAppSyncGraphQlApiLogConfigDetails;
const AwsAppSyncGraphQlApiOpenIdConnectConfigDetails = @import("aws_app_sync_graph_ql_api_open_id_connect_config_details.zig").AwsAppSyncGraphQlApiOpenIdConnectConfigDetails;
const AwsAppSyncGraphQlApiUserPoolConfigDetails = @import("aws_app_sync_graph_ql_api_user_pool_config_details.zig").AwsAppSyncGraphQlApiUserPoolConfigDetails;

/// Provides details about an AppSync Graph QL API, which lets you query
/// multiple databases, microservices, and APIs from a single GraphQL endpoint.
pub const AwsAppSyncGraphQlApiDetails = struct {
    /// A list of additional authentication providers for the GraphQL API.
    additional_authentication_providers: ?[]const AwsAppSyncGraphQlApiAdditionalAuthenticationProvidersDetails = null,

    /// The unique identifier for the API.
    api_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the API.
    arn: ?[]const u8 = null,

    /// The type of security configuration for your GraphQL API: API key, Identity
    /// and Access Management (IAM), OpenID Connect (OIDC), Amazon Cognito user
    /// pools, or Lambda.
    authentication_type: ?[]const u8 = null,

    /// The unique identifier for the API.
    id: ?[]const u8 = null,

    /// Specifies the configuration for Lambda function authorization.
    lambda_authorizer_config: ?AwsAppSyncGraphQlApiLambdaAuthorizerConfigDetails = null,

    /// The Amazon CloudWatch Logs configuration.
    log_config: ?AwsAppSyncGraphQlApiLogConfigDetails = null,

    /// The API name.
    name: ?[]const u8 = null,

    /// Specifies the authorization configuration for using an OpenID Connect
    /// compliant service with an AppSync GraphQL API endpoint.
    open_id_connect_config: ?AwsAppSyncGraphQlApiOpenIdConnectConfigDetails = null,

    /// The Amazon Cognito user pools configuration.
    user_pool_config: ?AwsAppSyncGraphQlApiUserPoolConfigDetails = null,

    /// The Amazon Resource Name (ARN) of the WAF web access control list (web ACL)
    /// associated with this
    /// GraphQL API, if one exists.
    waf_web_acl_arn: ?[]const u8 = null,

    /// Indicates whether to use X-Ray tracing for the GraphQL API.
    xray_enabled: ?bool = null,

    pub const json_field_names = .{
        .additional_authentication_providers = "AdditionalAuthenticationProviders",
        .api_id = "ApiId",
        .arn = "Arn",
        .authentication_type = "AuthenticationType",
        .id = "Id",
        .lambda_authorizer_config = "LambdaAuthorizerConfig",
        .log_config = "LogConfig",
        .name = "Name",
        .open_id_connect_config = "OpenIdConnectConfig",
        .user_pool_config = "UserPoolConfig",
        .waf_web_acl_arn = "WafWebAclArn",
        .xray_enabled = "XrayEnabled",
    };
};
