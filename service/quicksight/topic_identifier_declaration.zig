/// A topic.
pub const TopicIdentifierDeclaration = struct {
    /// The identifier of the topic, typically the topic's name.
    identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the topic.
    topic_arn: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .topic_arn = "TopicArn",
    };
};
