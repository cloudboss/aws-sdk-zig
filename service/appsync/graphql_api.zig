const aws = @import("aws");

const AdditionalAuthenticationProvider = @import("additional_authentication_provider.zig").AdditionalAuthenticationProvider;
const GraphQLApiType = @import("graph_ql_api_type.zig").GraphQLApiType;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const EnhancedMetricsConfig = @import("enhanced_metrics_config.zig").EnhancedMetricsConfig;
const GraphQLApiIntrospectionConfig = @import("graph_ql_api_introspection_config.zig").GraphQLApiIntrospectionConfig;
const LambdaAuthorizerConfig = @import("lambda_authorizer_config.zig").LambdaAuthorizerConfig;
const LogConfig = @import("log_config.zig").LogConfig;
const OpenIDConnectConfig = @import("open_id_connect_config.zig").OpenIDConnectConfig;
const UserPoolConfig = @import("user_pool_config.zig").UserPoolConfig;
const GraphQLApiVisibility = @import("graph_ql_api_visibility.zig").GraphQLApiVisibility;

/// Describes a GraphQL API.
pub const GraphqlApi = struct {
    /// A list of additional authentication providers for the `GraphqlApi`
    /// API.
    additional_authentication_providers: ?[]const AdditionalAuthenticationProvider = null,

    /// The API ID.
    api_id: ?[]const u8 = null,

    /// The value that indicates whether the GraphQL API is a standard API
    /// (`GRAPHQL`) or merged API (`MERGED`).
    api_type: ?GraphQLApiType = null,

    /// The Amazon Resource Name (ARN).
    arn: ?[]const u8 = null,

    /// The authentication type.
    authentication_type: ?AuthenticationType = null,

    /// The DNS records for the API.
    dns: ?[]const aws.map.StringMapEntry = null,

    /// The `enhancedMetricsConfig` object.
    enhanced_metrics_config: ?EnhancedMetricsConfig = null,

    /// Sets the value of the GraphQL API to enable (`ENABLED`) or disable
    /// (`DISABLED`) introspection. If no value is provided, the introspection
    /// configuration will be set to `ENABLED` by default. This field will produce
    /// an
    /// error if the operation attempts to use the introspection feature while this
    /// field is
    /// disabled.
    ///
    /// For more information about introspection, see [GraphQL
    /// introspection](https://graphql.org/learn/introspection/).
    introspection_config: ?GraphQLApiIntrospectionConfig = null,

    /// Configuration for Lambda function authorization.
    lambda_authorizer_config: ?LambdaAuthorizerConfig = null,

    /// The Amazon CloudWatch Logs configuration.
    log_config: ?LogConfig = null,

    /// The Identity and Access Management service role ARN for a merged API. The
    /// AppSync
    /// service assumes this role on behalf of the Merged API to validate access to
    /// source APIs at
    /// runtime and to prompt the `AUTO_MERGE` to update the merged API endpoint
    /// with
    /// the source API changes automatically.
    merged_api_execution_role_arn: ?[]const u8 = null,

    /// The API name.
    name: ?[]const u8 = null,

    /// The OpenID Connect configuration.
    open_id_connect_config: ?OpenIDConnectConfig = null,

    /// The account owner of the GraphQL API.
    owner: ?[]const u8 = null,

    /// The owner contact information for an API resource.
    ///
    /// This field accepts any string input with a length of 0 - 256 characters.
    owner_contact: ?[]const u8 = null,

    /// The maximum depth a query can have in a single request. Depth refers to the
    /// amount of
    /// nested levels allowed in the body of query. The default value is `0` (or
    /// unspecified), which indicates there's no depth limit. If you set a limit, it
    /// can be between
    /// `1` and `75` nested levels. This field will produce a limit error
    /// if the operation falls out of bounds.
    ///
    /// Note that fields can still be set to nullable or non-nullable. If a
    /// non-nullable field
    /// produces an error, the error will be thrown upwards to the first nullable
    /// field
    /// available.
    query_depth_limit: i32 = 0,

    /// The maximum number of resolvers that can be invoked in a single request. The
    /// default
    /// value is `0` (or unspecified), which will set the limit to `10000`.
    /// When specified, the limit value can be between `1` and `10000`. This
    /// field will produce a limit error if the operation falls out of bounds.
    resolver_count_limit: i32 = 0,

    /// The tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The URIs.
    uris: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Cognito user pool configuration.
    user_pool_config: ?UserPoolConfig = null,

    /// Sets the value of the GraphQL API to public (`GLOBAL`) or private
    /// (`PRIVATE`). If no value is provided, the visibility will be set to
    /// `GLOBAL` by default. This value cannot be changed once the API has been
    /// created.
    visibility: ?GraphQLApiVisibility = null,

    /// The ARN of the WAF access control list (ACL) associated with this
    /// `GraphqlApi`, if one exists.
    waf_web_acl_arn: ?[]const u8 = null,

    /// A flag indicating whether to use X-Ray tracing for this
    /// `GraphqlApi`.
    xray_enabled: bool = false,

    pub const json_field_names = .{
        .additional_authentication_providers = "additionalAuthenticationProviders",
        .api_id = "apiId",
        .api_type = "apiType",
        .arn = "arn",
        .authentication_type = "authenticationType",
        .dns = "dns",
        .enhanced_metrics_config = "enhancedMetricsConfig",
        .introspection_config = "introspectionConfig",
        .lambda_authorizer_config = "lambdaAuthorizerConfig",
        .log_config = "logConfig",
        .merged_api_execution_role_arn = "mergedApiExecutionRoleArn",
        .name = "name",
        .open_id_connect_config = "openIDConnectConfig",
        .owner = "owner",
        .owner_contact = "ownerContact",
        .query_depth_limit = "queryDepthLimit",
        .resolver_count_limit = "resolverCountLimit",
        .tags = "tags",
        .uris = "uris",
        .user_pool_config = "userPoolConfig",
        .visibility = "visibility",
        .waf_web_acl_arn = "wafWebAclArn",
        .xray_enabled = "xrayEnabled",
    };
};
