/// Configuration details of the Amazon SQS queue for EventBridge to use as a
/// dead-letter queue (DLQ).
///
/// For more information, see [Using dead-letter queues to process undelivered
/// events](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-rule-event-delivery.html#eb-rule-dlq) in the *EventBridge User
/// Guide*.
pub const DeadLetterConfig = struct {
    /// The ARN of the SQS queue specified as the target for the dead-letter queue.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
