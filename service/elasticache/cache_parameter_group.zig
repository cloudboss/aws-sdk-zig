/// Represents the output of a `CreateCacheParameterGroup` operation.
pub const CacheParameterGroup = struct {
    /// The ARN (Amazon Resource Name) of the cache parameter group.
    arn: ?[]const u8,

    /// The name of the cache parameter group family that this cache parameter group
    /// is
    /// compatible with.
    ///
    /// Valid values are: `memcached1.4` | `memcached1.5` |
    /// `memcached1.6` | `redis2.6` | `redis2.8` |
    /// `redis3.2` | `redis4.0` | `redis5.0` |
    /// `redis6.x` | `redis7`
    cache_parameter_group_family: ?[]const u8,

    /// The name of the cache parameter group.
    cache_parameter_group_name: ?[]const u8,

    /// The description for this cache parameter group.
    description: ?[]const u8,

    /// Indicates whether the parameter group is associated with a Global datastore
    is_global: ?bool,
};
