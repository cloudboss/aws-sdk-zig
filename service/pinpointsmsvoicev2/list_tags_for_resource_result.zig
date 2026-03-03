const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResult = struct {
    /// The ARN of the resource.
    resource_arn: ?[]const u8 = null,

    /// An array of key and value pair tags that are associated with the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
