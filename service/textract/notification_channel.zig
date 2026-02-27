/// The Amazon Simple Notification Service (Amazon SNS) topic to which Amazon
/// Textract publishes the completion status of
/// an asynchronous document operation.
pub const NotificationChannel = struct {
    /// The Amazon Resource Name (ARN) of an IAM role that gives Amazon Textract
    /// publishing permissions to the Amazon SNS topic.
    role_arn: []const u8,

    /// The Amazon SNS topic that Amazon Textract posts the completion status to.
    sns_topic_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .sns_topic_arn = "SNSTopicArn",
    };
};
