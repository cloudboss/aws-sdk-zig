/// The configuration for resource targets to receive notifications when meeting
/// and attendee events occur.
pub const NotificationsConfiguration = struct {
    /// The ARN of the Amazon Web Services Lambda function in the notifications
    /// configuration.
    lambda_function_arn: ?[]const u8 = null,

    /// The ARN of the SNS topic.
    sns_topic_arn: ?[]const u8 = null,

    /// The ARN of the SQS queue.
    sqs_queue_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .lambda_function_arn = "LambdaFunctionArn",
        .sns_topic_arn = "SnsTopicArn",
        .sqs_queue_arn = "SqsQueueArn",
    };
};
