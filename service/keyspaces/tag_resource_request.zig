const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Keyspaces resource to which to
    /// add tags.
    resource_arn: []const u8,

    /// The tags to be assigned to the Amazon Keyspaces resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
