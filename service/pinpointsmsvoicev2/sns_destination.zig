/// An object that defines an Amazon SNS destination for events. You can use
/// Amazon SNS to send notification when certain events occur.
pub const SnsDestination = struct {
    /// The Amazon Resource Name (ARN) of the Amazon SNS topic that you want to
    /// publish events to.
    topic_arn: []const u8,

    pub const json_field_names = .{
        .topic_arn = "TopicArn",
    };
};
