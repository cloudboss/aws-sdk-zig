/// A `DeadLetterConfig` object that contains information about a dead-letter
/// queue configuration.
pub const DeadLetterConfig = struct {
    /// The ARN of the specified target for the dead-letter queue.
    ///
    /// For Amazon Kinesis stream and Amazon DynamoDB stream sources, specify
    /// either an Amazon SNS topic or Amazon SQS queue ARN.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
