const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResult = struct {
    /// A list of tag key and value pairs associated with the specified resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
