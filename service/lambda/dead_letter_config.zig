/// The [dead-letter
/// queue](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async-retain-records.html#invocation-dlq) for failed asynchronous invocations.
pub const DeadLetterConfig = struct {
    /// The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .target_arn = "TargetArn",
    };
};
