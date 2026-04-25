const CacheUsageLimits = @import("cache_usage_limits.zig").CacheUsageLimits;
const Endpoint = @import("endpoint.zig").Endpoint;
const NetworkType = @import("network_type.zig").NetworkType;

/// The resource representing a serverless cache.
pub const ServerlessCache = struct {
    /// The Amazon Resource Name (ARN) of the serverless cache.
    arn: ?[]const u8 = null,

    /// The cache usage limit for the serverless cache.
    cache_usage_limits: ?CacheUsageLimits = null,

    /// When the serverless cache was created.
    create_time: ?i64 = null,

    /// The daily time that a cache snapshot will be created. Default is NULL, i.e.
    /// snapshots will not be created at a
    /// specific time on a daily basis. Available for Valkey, Redis OSS and
    /// Serverless Memcached only.
    daily_snapshot_time: ?[]const u8 = null,

    /// A description of the serverless cache.
    description: ?[]const u8 = null,

    endpoint: ?Endpoint = null,

    /// The engine the serverless cache is compatible with.
    engine: ?[]const u8 = null,

    /// The name and version number of the engine the serverless cache is compatible
    /// with.
    full_engine_version: ?[]const u8 = null,

    /// The ID of the Amazon Web Services Key Management Service (KMS) key that is
    /// used to encrypt data at rest in the serverless cache.
    kms_key_id: ?[]const u8 = null,

    /// The version number of the engine the serverless cache is compatible with.
    major_engine_version: ?[]const u8 = null,

    /// The type of IP address protocol used by the serverless cache.
    /// Must be either `ipv4` | `ipv6` | `dual_stack`.
    /// `ipv6` is only supported with IPv6-only subnets.
    /// If not specified, defaults to `ipv4`, unless all provided subnets are
    /// IPv6-only, in which case it defaults to `ipv6`.
    network_type: ?NetworkType = null,

    reader_endpoint: ?Endpoint = null,

    /// The IDs of the EC2 security groups associated with the serverless
    /// cache.
    security_group_ids: ?[]const []const u8 = null,

    /// The unique identifier of the serverless cache.
    serverless_cache_name: ?[]const u8 = null,

    /// The number of days for which ElastiCache retains automatic snapshots before
    /// deleting them. Available for Valkey, Redis OSS and Serverless Memcached
    /// only. The maximum value allowed is 35 days.
    snapshot_retention_limit: ?i32 = null,

    /// The current status of the serverless cache. The allowed values are CREATING,
    /// AVAILABLE, DELETING, CREATE-FAILED and MODIFYING.
    status: ?[]const u8 = null,

    /// If no subnet IDs are given and your VPC is in us-west-1, then ElastiCache
    /// will select 2 default subnets across AZs in your VPC.
    /// For all other Regions, if no subnet IDs are given then ElastiCache will
    /// select 3 default subnets across AZs in your default VPC.
    subnet_ids: ?[]const []const u8 = null,

    /// The identifier of the user group associated with the serverless cache.
    /// Available for Valkey and Redis OSS only. Default is NULL.
    user_group_id: ?[]const u8 = null,
};
