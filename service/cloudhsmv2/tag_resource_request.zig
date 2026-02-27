const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The cluster identifier (ID) for the cluster that you are tagging. To find
    /// the cluster
    /// ID, use DescribeClusters.
    resource_id: []const u8,

    /// A list of one or more tags.
    tag_list: []const Tag,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .tag_list = "TagList",
    };
};
