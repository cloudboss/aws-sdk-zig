const aws = @import("aws");

const AwsApiGatewayAccessLogSettings = @import("aws_api_gateway_access_log_settings.zig").AwsApiGatewayAccessLogSettings;
const AwsApiGatewayCanarySettings = @import("aws_api_gateway_canary_settings.zig").AwsApiGatewayCanarySettings;
const AwsApiGatewayMethodSettings = @import("aws_api_gateway_method_settings.zig").AwsApiGatewayMethodSettings;

/// Provides information about a version 1 Amazon API Gateway stage.
pub const AwsApiGatewayStageDetails = struct {
    /// Settings for logging access for the stage.
    access_log_settings: ?AwsApiGatewayAccessLogSettings,

    /// Indicates whether a cache cluster is enabled for the stage.
    cache_cluster_enabled: ?bool,

    /// If a cache cluster is enabled, the size of the cache cluster.
    cache_cluster_size: ?[]const u8,

    /// If a cache cluster is enabled, the status of the cache cluster.
    cache_cluster_status: ?[]const u8,

    /// Information about settings for canary deployment in the stage.
    canary_settings: ?AwsApiGatewayCanarySettings,

    /// The identifier of the client certificate for the stage.
    client_certificate_id: ?[]const u8,

    /// Indicates when the stage was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_date: ?[]const u8,

    /// The identifier of the deployment that the stage points to.
    deployment_id: ?[]const u8,

    /// A description of the stage.
    description: ?[]const u8,

    /// The version of the API documentation that is associated with the stage.
    documentation_version: ?[]const u8,

    /// Indicates when the stage was most recently updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_updated_date: ?[]const u8,

    /// Defines the method settings for the stage.
    method_settings: ?[]const AwsApiGatewayMethodSettings,

    /// The name of the stage.
    stage_name: ?[]const u8,

    /// Indicates whether active tracing with X-Ray is enabled for the stage.
    tracing_enabled: ?bool,

    /// A map that defines the stage variables for the stage.
    ///
    /// Variable names can have alphanumeric and underscore characters.
    ///
    /// Variable values can contain the following characters:
    ///
    /// * Uppercase and lowercase letters
    ///
    /// * Numbers
    ///
    /// * Special characters -._~:/?#&=,
    variables: ?[]const aws.map.StringMapEntry,

    /// The ARN of the web ACL associated with the stage.
    web_acl_arn: ?[]const u8,

    pub const json_field_names = .{
        .access_log_settings = "AccessLogSettings",
        .cache_cluster_enabled = "CacheClusterEnabled",
        .cache_cluster_size = "CacheClusterSize",
        .cache_cluster_status = "CacheClusterStatus",
        .canary_settings = "CanarySettings",
        .client_certificate_id = "ClientCertificateId",
        .created_date = "CreatedDate",
        .deployment_id = "DeploymentId",
        .description = "Description",
        .documentation_version = "DocumentationVersion",
        .last_updated_date = "LastUpdatedDate",
        .method_settings = "MethodSettings",
        .stage_name = "StageName",
        .tracing_enabled = "TracingEnabled",
        .variables = "Variables",
        .web_acl_arn = "WebAclArn",
    };
};
