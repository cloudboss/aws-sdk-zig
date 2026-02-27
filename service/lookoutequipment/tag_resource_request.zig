const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the specific resource to which the tag
    /// should be
    /// associated.
    resource_arn: []const u8,

    /// The tag or tags to be associated with a specific resource. Both the tag key
    /// and value
    /// are specified.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
