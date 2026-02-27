/// A `DeadLetterConfig` object that contains information about a dead-letter
/// queue
/// configuration.
pub const DeadLetterConfig = struct {
    /// The ARN of the SQS queue specified as the target for the dead-letter queue.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
