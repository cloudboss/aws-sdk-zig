const DeadLetterQueueS3 = @import("dead_letter_queue_s3.zig").DeadLetterQueueS3;
const S3Storage = @import("s3_storage.zig").S3Storage;

/// Configuration of an Amazon S3 destination for a channel.
pub const S3DestinationConfiguration = struct {
    /// The maximum time, in seconds, that records buffer in MSK before being
    /// flushed to the destination. Allowed range: 300 to 900. Default: 600.
    data_freshness_in_seconds: ?i32 = null,

    /// The Amazon S3 bucket and prefix where MSK writes records that fail to
    /// deliver.
    dead_letter_queue_s3: DeadLetterQueueS3,

    /// The Amazon Resource Name (ARN) of the IAM role that MSK assumes to write to
    /// the destination Amazon S3 bucket and the dead-letter bucket.
    service_execution_role_arn: []const u8,

    /// The Amazon S3 bucket, prefix, and storage class for delivered records.
    storage: S3Storage,

    pub const json_field_names = .{
        .data_freshness_in_seconds = "DataFreshnessInSeconds",
        .dead_letter_queue_s3 = "DeadLetterQueueS3",
        .service_execution_role_arn = "ServiceExecutionRoleArn",
        .storage = "Storage",
    };
};
