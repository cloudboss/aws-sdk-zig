/// Data about a queue.
pub const AwsSqsQueueDetails = struct {
    /// The ARN of the dead-letter queue to which Amazon SQS moves
    /// messages after the value of `maxReceiveCount` is exceeded.
    dead_letter_target_arn: ?[]const u8 = null,

    /// The length of time, in seconds, for which Amazon SQS can reuse a data key to
    /// encrypt or decrypt messages before calling KMS again.
    kms_data_key_reuse_period_seconds: ?i32 = null,

    /// The ID of an Amazon Web Services managed key for Amazon SQS or a custom
    /// KMS key.
    kms_master_key_id: ?[]const u8 = null,

    /// The name of the new queue.
    queue_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .dead_letter_target_arn = "DeadLetterTargetArn",
        .kms_data_key_reuse_period_seconds = "KmsDataKeyReusePeriodSeconds",
        .kms_master_key_id = "KmsMasterKeyId",
        .queue_name = "QueueName",
    };
};
