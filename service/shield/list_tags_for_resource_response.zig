const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// A list of tag key and value pairs associated with the specified resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
