const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// Required. The Amazon Resource Name (ARN) associated with the resource you
    /// want to
    /// tag.
    resource_arn: []const u8,

    /// Required. A list of objects specifying each key name and value. Number of
    /// objects
    /// allowed: 1-50.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
