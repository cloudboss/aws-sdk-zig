/// A value that applies only to a certain cache node type.
pub const CacheNodeTypeSpecificValue = struct {
    /// The cache node type for which this value applies.
    cache_node_type: ?[]const u8 = null,

    /// The value for the cache node type.
    value: ?[]const u8 = null,
};
