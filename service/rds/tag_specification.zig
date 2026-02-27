const Tag = @import("tag.zig").Tag;

/// The tags to apply to resources when creating or modifying a DB instance or
/// DB cluster. When you specify a tag, you must specify the resource type to
/// tag, otherwise the request will fail.
pub const TagSpecification = struct {
    /// The type of resource to tag on creation.
    ///
    /// Valid Values:
    ///
    /// * `auto-backup` - The DB instance's automated backup.
    /// * `cluster-auto-backup` - The DB cluster's automated backup.
    resource_type: ?[]const u8,

    tags: ?[]const Tag,
};
