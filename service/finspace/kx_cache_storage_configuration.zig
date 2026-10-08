/// The configuration for read only disk cache associated with a cluster.
pub const KxCacheStorageConfiguration = struct {
    /// The size of cache in Gigabytes.
    size: i32,

    /// The type of cache storage. The valid values are:
    ///
    /// * CACHE_1000 – This type provides at least 1000 MB/s disk access throughput.
    ///
    /// * CACHE_250 – This type provides at least 250 MB/s disk access throughput.
    ///
    /// * CACHE_12 – This type provides at least 12 MB/s disk access throughput.
    ///
    /// For cache type `CACHE_1000` and `CACHE_250` you can select cache size as
    /// 1200 GB or increments of 2400 GB. For cache type `CACHE_12` you can select
    /// the cache size in increments of 6000 GB.
    type: []const u8,

    pub const json_field_names = .{
        .size = "size",
        .type = "type",
    };
};
