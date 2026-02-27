const Tag = @import("tag.zig").Tag;

pub const UntagResourceRequest = struct {
    /// The Amazon Keyspaces resource that the tags will be removed from. This value
    /// is an Amazon Resource Name (ARN).
    resource_arn: []const u8,

    /// A list of existing tags to be removed from the Amazon Keyspaces resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
