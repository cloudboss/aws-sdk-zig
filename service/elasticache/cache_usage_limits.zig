const DataStorage = @import("data_storage.zig").DataStorage;
const ECPUPerSecond = @import("ecpu_per_second.zig").ECPUPerSecond;

/// The usage limits for storage and ElastiCache Processing Units for the cache.
pub const CacheUsageLimits = struct {
    /// The maximum data storage limit in the cache, expressed in Gigabytes.
    data_storage: ?DataStorage,

    ecpu_per_second: ?ECPUPerSecond,
};
