const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ARN of the EventBridge resource that you're adding tags to.
    resource_arn: []const u8,

    /// The list of key-value pairs to associate with the resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
