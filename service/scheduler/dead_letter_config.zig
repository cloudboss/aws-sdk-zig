/// An object that contains information about an Amazon SQS queue that
/// EventBridge Scheduler uses as a dead-letter queue for your schedule. If
/// specified, EventBridge Scheduler delivers failed events that could not be
/// successfully delivered to a target to the queue.
pub const DeadLetterConfig = struct {
    /// The Amazon Resource Name (ARN) of the SQS queue specified as the destination
    /// for the dead-letter queue.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
