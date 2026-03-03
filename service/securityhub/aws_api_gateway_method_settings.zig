/// Defines settings for a method for the stage.
pub const AwsApiGatewayMethodSettings = struct {
    /// Indicates whether the cached responses are encrypted.
    cache_data_encrypted: ?bool = null,

    /// Specifies the time to live (TTL), in seconds, for cached responses. The
    /// higher the TTL,
    /// the longer the response is cached.
    cache_ttl_in_seconds: ?i32 = null,

    /// Indicates whether responses are cached and returned for requests. For
    /// responses to be
    /// cached, a cache cluster must be enabled on the stage.
    caching_enabled: ?bool = null,

    /// Indicates whether data trace logging is enabled for the method. Data trace
    /// logging
    /// affects the log entries that are pushed to CloudWatch Logs.
    data_trace_enabled: ?bool = null,

    /// The HTTP method. You can use an asterisk (*) as a wildcard to apply method
    /// settings to
    /// multiple methods.
    http_method: ?[]const u8 = null,

    /// The logging level for this method. The logging level affects the log entries
    /// that are
    /// pushed to CloudWatch Logs.
    ///
    /// If the logging level is `ERROR`, then the logs only include error-level
    /// entries.
    ///
    /// If the logging level is `INFO`, then the logs include both `ERROR`
    /// events and extra informational events.
    ///
    /// Valid values: `OFF` | `ERROR` | `INFO`
    logging_level: ?[]const u8 = null,

    /// Indicates whether CloudWatch metrics are enabled for the method.
    metrics_enabled: ?bool = null,

    /// Indicates whether authorization is required for a cache invalidation
    /// request.
    require_authorization_for_cache_control: ?bool = null,

    /// The resource path for this method. Forward slashes (/) are encoded as ~1 .
    /// The initial
    /// slash must include a forward slash.
    ///
    /// For example, the path value `/resource/subresource` must be encoded as
    /// `/~1resource~1subresource`.
    ///
    /// To specify the root path, use only a slash (/). You can use an asterisk (*)
    /// as a
    /// wildcard to apply method settings to multiple methods.
    resource_path: ?[]const u8 = null,

    /// The throttling burst limit for the method.
    throttling_burst_limit: ?i32 = null,

    /// The throttling rate limit for the method.
    throttling_rate_limit: ?f64 = null,

    /// Indicates how to handle unauthorized requests for cache invalidation.
    ///
    /// Valid values: `FAIL_WITH_403` | `SUCCEED_WITH_RESPONSE_HEADER` |
    /// `SUCCEED_WITHOUT_RESPONSE_HEADER`
    unauthorized_cache_control_header_strategy: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_data_encrypted = "CacheDataEncrypted",
        .cache_ttl_in_seconds = "CacheTtlInSeconds",
        .caching_enabled = "CachingEnabled",
        .data_trace_enabled = "DataTraceEnabled",
        .http_method = "HttpMethod",
        .logging_level = "LoggingLevel",
        .metrics_enabled = "MetricsEnabled",
        .require_authorization_for_cache_control = "RequireAuthorizationForCacheControl",
        .resource_path = "ResourcePath",
        .throttling_burst_limit = "ThrottlingBurstLimit",
        .throttling_rate_limit = "ThrottlingRateLimit",
        .unauthorized_cache_control_header_strategy = "UnauthorizedCacheControlHeaderStrategy",
    };
};
