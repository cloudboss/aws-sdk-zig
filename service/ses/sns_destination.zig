/// Contains the topic ARN associated with an Amazon Simple Notification Service
/// (Amazon SNS) event destination.
///
/// Event destinations, such as Amazon SNS, are associated with configuration
/// sets, which
/// enable you to publish email sending events. For information about using
/// configuration
/// sets, see the [Amazon SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
pub const SNSDestination = struct {
    /// The ARN of the Amazon SNS topic for email sending events. You can find the
    /// ARN of a topic
    /// by using the
    /// [ListTopics](https://docs.aws.amazon.com/sns/latest/api/API_ListTopics.html)
    /// Amazon SNS operation.
    ///
    /// For more information about Amazon SNS topics, see the [Amazon SNS Developer
    /// Guide](https://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html).
    topic_arn: []const u8,
};
