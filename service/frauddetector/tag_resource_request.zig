const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The resource ARN.
    resource_arn: []const u8,

    /// The tags to assign to the resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tags = "tags",
    };
};
