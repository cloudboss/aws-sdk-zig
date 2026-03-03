const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const RunCacheStatus = @import("run_cache_status.zig").RunCacheStatus;

/// List entry for one run cache.
pub const RunCacheListItem = struct {
    /// Unique resource identifier for the run cache.
    arn: ?[]const u8 = null,

    /// Default cache behavior for the run cache.
    cache_behavior: ?CacheBehavior = null,

    /// The S3 uri for the run cache data.
    cache_s3_uri: ?[]const u8 = null,

    /// The time that this run cache was created (an ISO 8601 formatted string).
    creation_time: ?i64 = null,

    /// The identifier for this run cache.
    id: ?[]const u8 = null,

    /// The name of the run cache.
    name: ?[]const u8 = null,

    /// The run cache status.
    status: ?RunCacheStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cache_behavior = "cacheBehavior",
        .cache_s3_uri = "cacheS3Uri",
        .creation_time = "creationTime",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
