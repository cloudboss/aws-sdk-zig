const Tag = @import("tag.zig").Tag;

/// A resource tag.
pub const ResourceTag = struct {
    /// Specifies the ARN of the resource.
    resource_id: ?[]const u8,

    /// A list of tags.
    tags_list: ?[]const Tag,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .tags_list = "TagsList",
    };
};
