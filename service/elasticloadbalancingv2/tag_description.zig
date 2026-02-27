const Tag = @import("tag.zig").Tag;

/// The tags associated with a resource.
pub const TagDescription = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8,

    /// Information about the tags.
    tags: ?[]const Tag,
};
