/// An object that contains information about an event destination that sends
/// data to Amazon SNS.
pub const SnsDestination = struct {
    /// The Amazon Resource Name (ARN) of the Amazon SNS topic that you want to
    /// publish events to.
    topic_arn: ?[]const u8,

    pub const json_field_names = .{
        .topic_arn = "TopicArn",
    };
};
