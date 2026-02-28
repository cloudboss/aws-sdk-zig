const ApiCachingBehavior = @import("api_caching_behavior.zig").ApiCachingBehavior;
const CacheHealthMetricsConfig = @import("cache_health_metrics_config.zig").CacheHealthMetricsConfig;
const ApiCacheStatus = @import("api_cache_status.zig").ApiCacheStatus;
const ApiCacheType = @import("api_cache_type.zig").ApiCacheType;

/// The `ApiCache` object.
pub const ApiCache = struct {
    /// Caching behavior.
    ///
    /// * **FULL_REQUEST_CACHING**: All requests from the
    /// same user are cached. Individual resolvers are automatically cached. All API
    /// calls
    /// will try to return responses from the cache.
    ///
    /// * **PER_RESOLVER_CACHING**: Individual resolvers
    /// that you specify are cached.
    ///
    /// * **OPERATION_LEVEL_CACHING**: Full requests are cached together and
    ///   returned without executing resolvers.
    api_caching_behavior: ?ApiCachingBehavior,

    /// At-rest encryption flag for cache. You cannot update this setting after
    /// creation.
    at_rest_encryption_enabled: bool = false,

    /// Controls how cache health metrics will be emitted to CloudWatch. Cache
    /// health metrics
    /// include:
    ///
    /// * NetworkBandwidthOutAllowanceExceeded: The network packets dropped because
    ///   the
    /// throughput exceeded the aggregated bandwidth limit. This is useful for
    /// diagnosing
    /// bottlenecks in a cache configuration.
    ///
    /// * EngineCPUUtilization: The CPU utilization (percentage) allocated to the
    ///   Redis
    /// process. This is useful for diagnosing bottlenecks in a cache
    /// configuration.
    ///
    /// Metrics will be recorded by API ID. You can set the value to `ENABLED` or
    /// `DISABLED`.
    health_metrics_config: ?CacheHealthMetricsConfig,

    /// The cache instance status.
    ///
    /// * **AVAILABLE**: The instance is available for
    /// use.
    ///
    /// * **CREATING**: The instance is currently
    /// creating.
    ///
    /// * **DELETING**: The instance is currently
    /// deleting.
    ///
    /// * **MODIFYING**: The instance is currently
    /// modifying.
    ///
    /// * **FAILED**: The instance has failed
    /// creation.
    status: ?ApiCacheStatus,

    /// Transit encryption flag when connecting to cache. You cannot update this
    /// setting after
    /// creation.
    transit_encryption_enabled: bool = false,

    /// TTL in seconds for cache entries.
    ///
    /// Valid values are 1–3,600 seconds.
    ttl: i64 = 0,

    /// The cache instance type. Valid values are
    ///
    /// * `SMALL`
    ///
    /// * `MEDIUM`
    ///
    /// * `LARGE`
    ///
    /// * `XLARGE`
    ///
    /// * `LARGE_2X`
    ///
    /// * `LARGE_4X`
    ///
    /// * `LARGE_8X` (not available in all regions)
    ///
    /// * `LARGE_12X`
    ///
    /// Historically, instance types were identified by an EC2-style value. As of
    /// July 2020, this is deprecated, and the generic identifiers above should be
    /// used.
    ///
    /// The following legacy instance types are available, but their use is
    /// discouraged:
    ///
    /// * **T2_SMALL**: A t2.small instance type.
    ///
    /// * **T2_MEDIUM**: A t2.medium instance type.
    ///
    /// * **R4_LARGE**: A r4.large instance type.
    ///
    /// * **R4_XLARGE**: A r4.xlarge instance type.
    ///
    /// * **R4_2XLARGE**: A r4.2xlarge instance type.
    ///
    /// * **R4_4XLARGE**: A r4.4xlarge instance type.
    ///
    /// * **R4_8XLARGE**: A r4.8xlarge instance type.
    @"type": ?ApiCacheType,

    pub const json_field_names = .{
        .api_caching_behavior = "apiCachingBehavior",
        .at_rest_encryption_enabled = "atRestEncryptionEnabled",
        .health_metrics_config = "healthMetricsConfig",
        .status = "status",
        .transit_encryption_enabled = "transitEncryptionEnabled",
        .ttl = "ttl",
        .@"type" = "type",
    };
};
