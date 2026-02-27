const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ARN of the resource.
    resource_arn: []const u8,

    /// The tags to attach to the resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
