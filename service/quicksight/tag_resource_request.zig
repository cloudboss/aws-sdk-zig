const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to tag.
    resource_arn: []const u8,

    /// Contains a map of the key-value pairs for the resource tag or tags assigned
    /// to the
    /// resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
