/// The override parameters for a single topic that is being imported.
pub const AssetBundleImportJobTopicV2OverrideParameters = struct {
    /// A new description for the topic.
    description: ?[]const u8 = null,

    /// A new name for the topic.
    name: ?[]const u8 = null,

    /// The ID of the topic that you want to apply overrides to.
    topic_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .topic_id = "TopicId",
    };
};
