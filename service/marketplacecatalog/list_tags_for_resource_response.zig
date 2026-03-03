const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// Required. The ARN associated with the resource you want to list tags on.
    resource_arn: ?[]const u8 = null,

    /// Required. A list of objects specifying each key name and value. Number of
    /// objects
    /// allowed: 1-50.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
