const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ARN of the topic to which to add tags.
    resource_arn: []const u8,

    /// The tags to be added to the specified topic. A tag consists of a required
    /// key and an
    /// optional value.
    tags: []const Tag,
};
