const Tag = @import("tag.zig").Tag;

/// Information about a tag associated with an Direct Connect resource.
pub const ResourceTag = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8,

    /// The tags.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
