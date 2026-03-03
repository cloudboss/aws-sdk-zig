const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResult = struct {
    /// The tags related to the contact or escalation plan.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
