const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ARN of the resource to add tags to.
    resource_arn: []const u8,

    /// Adds to or modifies the tags of the given resource. Tags are metadata that
    /// you can use
    /// to manage a resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
