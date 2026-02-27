/// The dead-letter queue for failed asynchronous invocations.
pub const AwsLambdaFunctionDeadLetterConfig = struct {
    /// The ARN of an SQS queue or SNS topic.
    target_arn: ?[]const u8,

    pub const json_field_names = .{
        .target_arn = "TargetArn",
    };
};
