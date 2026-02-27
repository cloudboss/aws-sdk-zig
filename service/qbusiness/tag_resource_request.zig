const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q Business application or data
    /// source to tag.
    resource_arn: []const u8,

    /// A list of tag keys to add to the Amazon Q Business application or data
    /// source. If a tag already exists, the existing value is replaced with the new
    /// value.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tags = "tags",
    };
};
