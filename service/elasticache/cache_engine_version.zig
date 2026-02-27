/// Provides all of the details about a particular cache engine version.
pub const CacheEngineVersion = struct {
    /// The description of the cache engine.
    cache_engine_description: ?[]const u8,

    /// The description of the cache engine version.
    cache_engine_version_description: ?[]const u8,

    /// The name of the cache parameter group family associated with this cache
    /// engine.
    ///
    /// Valid values are: `memcached1.4` | `memcached1.5` |
    /// `memcached1.6` | `redis2.6` | `redis2.8` |
    /// `redis3.2` | `redis4.0` | `redis5.0` |
    /// `redis6.x` | `redis7`
    cache_parameter_group_family: ?[]const u8,

    /// The name of the cache engine.
    engine: ?[]const u8,

    /// The version number of the cache engine.
    engine_version: ?[]const u8,
};
