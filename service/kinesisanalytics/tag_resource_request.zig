const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ARN of the application to assign the tags.
    resource_arn: []const u8,

    /// The key-value tags to assign to the application.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
