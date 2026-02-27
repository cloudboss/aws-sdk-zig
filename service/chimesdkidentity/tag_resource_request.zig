const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The resource ARN.
    resource_arn: []const u8,

    /// The tag key-value pairs.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
