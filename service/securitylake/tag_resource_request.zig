const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Security Lake resource to add
    /// or update the tags for.
    resource_arn: []const u8,

    /// An array of objects, one for each tag (key and value) to associate with the
    /// Amazon Security Lake resource. For each tag, you must
    /// specify both a tag key and a tag value. A tag value cannot be null, but it
    /// can be an empty string.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
