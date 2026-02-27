const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The name of the DAX resource to which tags should be
    /// added.
    resource_name: []const u8,

    /// The tags to be assigned to the DAX resource.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_name = "ResourceName",
        .tags = "Tags",
    };
};
