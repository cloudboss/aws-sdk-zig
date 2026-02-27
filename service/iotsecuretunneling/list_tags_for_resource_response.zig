const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The tags for the specified resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
