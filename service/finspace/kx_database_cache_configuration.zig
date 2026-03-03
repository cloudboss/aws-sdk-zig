/// The structure of database cache configuration that is used for mapping
/// database paths to cache types in clusters.
pub const KxDatabaseCacheConfiguration = struct {
    /// The type of disk cache. This parameter is used to map the database path to
    /// cache storage. The valid values are:
    ///
    /// * CACHE_1000 – This type provides at least 1000 MB/s disk access throughput.
    cache_type: []const u8,

    /// The name of the dataview to be used for caching historical data on disk.
    dataview_name: ?[]const u8 = null,

    /// Specifies the portions of database that will be loaded into the cache for
    /// access.
    db_paths: []const []const u8,

    pub const json_field_names = .{
        .cache_type = "cacheType",
        .dataview_name = "dataviewName",
        .db_paths = "dbPaths",
    };
};
