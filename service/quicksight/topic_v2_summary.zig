/// A summary of the topic.
pub const TopicV2Summary = struct {
    /// The Amazon Resource Name (ARN) of the topic.
    arn: ?[]const u8 = null,

    /// The name of the topic.
    name: ?[]const u8 = null,

    /// The ID of the topic. This ID is unique per Amazon Web Services Region for
    /// each Amazon Web Services account.
    topic_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .topic_id = "TopicId",
    };
};
