const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ARN of the ACM resource to which the tag is to be applied.
    resource_arn: []const u8,

    /// The key-value pair that defines the tag to apply.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
