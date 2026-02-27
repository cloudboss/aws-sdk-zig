const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to tag.
    resource_arn: []const u8,

    /// The map of the key-value pairs used to tag the resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
