/// When included in a receipt rule, this action rejects the received email by
/// returning a
/// bounce response to the sender and, optionally, publishes a notification to
/// Amazon Simple Notification Service
/// (Amazon SNS).
///
/// For information about sending a bounce message in response to a received
/// email, see
/// the [Amazon SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-action-bounce.html).
pub const BounceAction = struct {
    /// Human-readable text to include in the bounce message.
    message: []const u8,

    /// The email address of the sender of the bounced email. This is the address
    /// from which
    /// the bounce message is sent.
    sender: []const u8,

    /// The SMTP reply code, as defined by [RFC
    /// 5321](https://tools.ietf.org/html/rfc5321).
    smtp_reply_code: []const u8,

    /// The SMTP enhanced status code, as defined by [RFC
    /// 3463](https://tools.ietf.org/html/rfc3463).
    status_code: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic to notify when the
    /// bounce action is
    /// taken. You can find the ARN of a topic by using the
    /// [ListTopics](https://docs.aws.amazon.com/sns/latest/api/API_ListTopics.html)
    /// operation in
    /// Amazon SNS.
    ///
    /// For more information about Amazon SNS topics, see the [Amazon SNS Developer
    /// Guide](https://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html).
    topic_arn: ?[]const u8 = null,
};
