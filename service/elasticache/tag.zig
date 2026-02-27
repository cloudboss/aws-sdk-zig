/// A tag that can be added to an ElastiCache cluster or replication group. Tags
/// are
/// composed of a Key/Value pair. You can use tags to categorize and track all
/// your
/// ElastiCache resources, with the exception of global replication group. When
/// you add or
/// remove tags on replication groups, those actions will be replicated to all
/// nodes in the
/// replication group. A tag with a null Value is permitted.
pub const Tag = struct {
    /// The key for the tag. May not be null.
    key: ?[]const u8,

    /// The tag's value. May be null.
    value: ?[]const u8,
};
