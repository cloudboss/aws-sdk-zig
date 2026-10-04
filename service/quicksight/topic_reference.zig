/// Topic reference.
pub const TopicReference = struct {
    /// Topic Amazon Resource Name (ARN).
    topic_arn: []const u8,

    /// Topic placeholder.
    topic_placeholder: []const u8,

    pub const json_field_names = .{
        .topic_arn = "TopicArn",
        .topic_placeholder = "TopicPlaceholder",
    };
};
