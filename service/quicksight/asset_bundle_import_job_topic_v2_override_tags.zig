const Tag = @import("tag.zig").Tag;

/// An object that contains a list of tags to be assigned to a list of topic
/// IDs.
pub const AssetBundleImportJobTopicV2OverrideTags = struct {
    /// A list of tags for the topics that you want to apply overrides to.
    tags: []const Tag,

    /// A list of topic IDs that you want to apply overrides to. You can use `*` to
    /// override all topics in this asset bundle.
    topic_ids: []const []const u8,

    pub const json_field_names = .{
        .tags = "Tags",
        .topic_ids = "TopicIds",
    };
};
