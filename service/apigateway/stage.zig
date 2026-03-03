const aws = @import("aws");

const AccessLogSettings = @import("access_log_settings.zig").AccessLogSettings;
const CacheClusterSize = @import("cache_cluster_size.zig").CacheClusterSize;
const CacheClusterStatus = @import("cache_cluster_status.zig").CacheClusterStatus;
const CanarySettings = @import("canary_settings.zig").CanarySettings;
const MethodSetting = @import("method_setting.zig").MethodSetting;

/// Represents a unique identifier for a version of a deployed RestApi that is
/// callable by users.
pub const Stage = struct {
    /// Settings for logging access in this stage.
    access_log_settings: ?AccessLogSettings = null,

    /// Specifies whether a cache cluster is enabled for the stage. To activate a
    /// method-level cache, set `CachingEnabled` to `true` for a method.
    cache_cluster_enabled: bool = false,

    /// The stage's cache capacity in GB. For more information about choosing a
    /// cache size, see [Enabling API caching to enhance
    /// responsiveness](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html).
    cache_cluster_size: ?CacheClusterSize = null,

    /// The status of the cache cluster for the stage, if enabled.
    cache_cluster_status: ?CacheClusterStatus = null,

    /// Settings for the canary deployment in this stage.
    canary_settings: ?CanarySettings = null,

    /// The identifier of a client certificate for an API stage.
    client_certificate_id: ?[]const u8 = null,

    /// The timestamp when the stage was created.
    created_date: ?i64 = null,

    /// The identifier of the Deployment that the stage points to.
    deployment_id: ?[]const u8 = null,

    /// The stage's description.
    description: ?[]const u8 = null,

    /// The version of the associated API documentation.
    documentation_version: ?[]const u8 = null,

    /// The timestamp when the stage last updated.
    last_updated_date: ?i64 = null,

    /// A map that defines the method settings for a Stage resource. Keys
    /// (designated as `/{method_setting_key` below) are method paths defined as
    /// `{resource_path}/{http_method}` for an individual method override, or
    /// `/\*/\*` for overriding all methods in the stage.
    method_settings: ?[]const aws.map.MapEntry(MethodSetting) = null,

    /// The name of the stage is the first path segment in the Uniform Resource
    /// Identifier (URI) of a call to API Gateway. Stage names can only contain
    /// alphanumeric characters, hyphens, and underscores. Maximum length is 128
    /// characters.
    stage_name: ?[]const u8 = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether active tracing with X-ray is enabled for the Stage.
    tracing_enabled: bool = false,

    /// A map that defines the stage variables for a Stage resource. Variable names
    /// can
    /// have alphanumeric and underscore characters, and the values must match
    /// `[A-Za-z0-9-._~:/?#&=,]+`.
    variables: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the WebAcl associated with the Stage.
    web_acl_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_log_settings = "accessLogSettings",
        .cache_cluster_enabled = "cacheClusterEnabled",
        .cache_cluster_size = "cacheClusterSize",
        .cache_cluster_status = "cacheClusterStatus",
        .canary_settings = "canarySettings",
        .client_certificate_id = "clientCertificateId",
        .created_date = "createdDate",
        .deployment_id = "deploymentId",
        .description = "description",
        .documentation_version = "documentationVersion",
        .last_updated_date = "lastUpdatedDate",
        .method_settings = "methodSettings",
        .stage_name = "stageName",
        .tags = "tags",
        .tracing_enabled = "tracingEnabled",
        .variables = "variables",
        .web_acl_arn = "webAclArn",
    };
};
