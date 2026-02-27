const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// An array that lists all the tags that are associated with the application.
    /// Each tag
    /// consists of a required tag key (`Key`) and an associated tag value
    /// (`Value`).
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
