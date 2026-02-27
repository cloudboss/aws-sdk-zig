/// An object that defines an Amazon SNS destination for email events. You can
/// use Amazon SNS to
/// send notifications when certain email events occur.
pub const SnsDestination = struct {
    /// The Amazon Resource Name (ARN) of the Amazon SNS topic to publish email
    /// events to. For
    /// more information about Amazon SNS topics, see the [Amazon SNS Developer
    /// Guide](https://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html).
    topic_arn: []const u8,

    pub const json_field_names = .{
        .topic_arn = "TopicArn",
    };
};
