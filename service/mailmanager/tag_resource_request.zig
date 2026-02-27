const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to tag.
    resource_arn: []const u8,

    /// The tags used to organize, track, or control access for the resource. For
    /// example, { "tags": {"key1":"value1", "key2":"value2"} }.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
