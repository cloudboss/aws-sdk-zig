const ServerlessCacheConfiguration = @import("serverless_cache_configuration.zig").ServerlessCacheConfiguration;

/// The resource representing a serverless cache snapshot. Available for Valkey,
/// Redis OSS and Serverless Memcached only.
pub const ServerlessCacheSnapshot = struct {
    /// The Amazon Resource Name (ARN) of a serverless cache snapshot. Available for
    /// Valkey, Redis OSS and Serverless Memcached only.
    arn: ?[]const u8 = null,

    /// The total size of a serverless cache snapshot, in bytes. Available for
    /// Valkey, Redis OSS and Serverless Memcached only.
    bytes_used_for_cache: ?[]const u8 = null,

    /// The date and time that the source serverless cache's metadata and cache data
    /// set was obtained for
    /// the snapshot. Available for Valkey, Redis OSS and Serverless Memcached only.
    create_time: ?i64 = null,

    /// The time that the serverless cache snapshot will expire. Available for
    /// Valkey, Redis OSS and Serverless Memcached only.
    expiry_time: ?i64 = null,

    /// The ID of the Amazon Web Services Key Management Service (KMS) key of a
    /// serverless cache snapshot. Available for Valkey, Redis OSS and Serverless
    /// Memcached only.
    kms_key_id: ?[]const u8 = null,

    /// The configuration of the serverless cache, at the time the snapshot was
    /// taken. Available for Valkey, Redis OSS and Serverless Memcached only.
    serverless_cache_configuration: ?ServerlessCacheConfiguration = null,

    /// The identifier of a serverless cache snapshot. Available for Valkey, Redis
    /// OSS and Serverless Memcached only.
    serverless_cache_snapshot_name: ?[]const u8 = null,

    /// The type of snapshot of serverless cache. Available for Valkey, Redis OSS
    /// and Serverless Memcached only.
    snapshot_type: ?[]const u8 = null,

    /// The current status of the serverless cache. Available for Valkey, Redis OSS
    /// and Serverless Memcached only.
    status: ?[]const u8 = null,
};
