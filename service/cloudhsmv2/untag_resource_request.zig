pub const UntagResourceRequest = struct {
    /// The cluster identifier (ID) for the cluster whose tags you are removing. To
    /// find the
    /// cluster ID, use DescribeClusters.
    resource_id: []const u8,

    /// A list of one or more tag keys for the tags that you are removing. Specify
    /// only the tag
    /// keys, not the tag values.
    tag_key_list: []const []const u8,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .tag_key_list = "TagKeyList",
    };
};
