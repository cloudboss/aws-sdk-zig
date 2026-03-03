const UnauthorizedCacheControlHeaderStrategy = @import("unauthorized_cache_control_header_strategy.zig").UnauthorizedCacheControlHeaderStrategy;

/// Specifies the method setting properties.
pub const MethodSetting = struct {
    /// Specifies whether the cached responses are encrypted.
    cache_data_encrypted: bool = false,

    /// Specifies the time to live (TTL), in seconds, for cached responses. The
    /// higher the TTL, the longer the response will be cached.
    cache_ttl_in_seconds: i32 = 0,

    /// Specifies whether responses should be cached and returned for requests. A
    /// cache cluster must be enabled on the stage for responses to be cached.
    caching_enabled: bool = false,

    /// Specifies whether data trace logging is enabled for this method, which
    /// affects the log entries pushed to Amazon CloudWatch Logs. This can be useful
    /// to troubleshoot APIs, but can result in logging sensitive data. We recommend
    /// that you don't enable this option for production APIs.
    data_trace_enabled: bool = false,

    /// Specifies the logging level for this method, which affects the log entries
    /// pushed to Amazon CloudWatch Logs. Valid values are `OFF`, `ERROR`, and
    /// `INFO`. Choose `ERROR` to write only error-level entries to CloudWatch Logs,
    /// or choose `INFO` to include all `ERROR` events as well as extra
    /// informational events.
    logging_level: ?[]const u8 = null,

    /// Specifies whether Amazon CloudWatch metrics are enabled for this method.
    metrics_enabled: bool = false,

    /// Specifies whether authorization is required for a cache invalidation
    /// request.
    require_authorization_for_cache_control: bool = false,

    /// Specifies the throttling burst limit.
    throttling_burst_limit: i32 = 0,

    /// Specifies the throttling rate limit.
    throttling_rate_limit: f64 = 0,

    /// Specifies how to handle unauthorized requests for cache invalidation.
    unauthorized_cache_control_header_strategy: ?UnauthorizedCacheControlHeaderStrategy = null,

    pub const json_field_names = .{
        .cache_data_encrypted = "cacheDataEncrypted",
        .cache_ttl_in_seconds = "cacheTtlInSeconds",
        .caching_enabled = "cachingEnabled",
        .data_trace_enabled = "dataTraceEnabled",
        .logging_level = "loggingLevel",
        .metrics_enabled = "metricsEnabled",
        .require_authorization_for_cache_control = "requireAuthorizationForCacheControl",
        .throttling_burst_limit = "throttlingBurstLimit",
        .throttling_rate_limit = "throttlingRateLimit",
        .unauthorized_cache_control_header_strategy = "unauthorizedCacheControlHeaderStrategy",
    };
};
