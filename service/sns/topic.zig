/// A wrapper type for the topic's Amazon Resource Name (ARN). To retrieve a
/// topic's
/// attributes, use `GetTopicAttributes`.
pub const Topic = struct {
    /// The topic's ARN.
    topic_arn: ?[]const u8,
};
