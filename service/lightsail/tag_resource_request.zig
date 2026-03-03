const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to which you want to add a
    /// tag.
    resource_arn: ?[]const u8 = null,

    /// The name of the resource to which you are adding tags.
    resource_name: []const u8,

    /// The tag key and optional value.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .resource_name = "resourceName",
        .tags = "tags",
    };
};
