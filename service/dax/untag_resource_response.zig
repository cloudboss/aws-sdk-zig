const Tag = @import("tag.zig").Tag;

pub const UntagResourceResponse = struct {
    /// The tag keys that have been removed from the cluster.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
