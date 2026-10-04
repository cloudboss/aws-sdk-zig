const DeadLetterQueueS3Configuration = @import("dead_letter_queue_s3_configuration.zig").DeadLetterQueueS3Configuration;
const S3StorageConfiguration = @import("s3_storage_configuration.zig").S3StorageConfiguration;

/// The configuration for delivery to a general purpose Amazon S3 bucket.
/// Returned in ChannelDescription.
pub const S3DestinationDescription = struct {
    /// The maximum age, in seconds, of undelivered data.
    data_freshness_in_seconds: i32,

    /// The dead-letter queue configuration for records that cannot be delivered.
    dead_letter_queue_s3_configuration: DeadLetterQueueS3Configuration,

    /// The Amazon S3 storage configuration for the channel.
    storage_configuration: S3StorageConfiguration,

    pub const json_field_names = .{
        .data_freshness_in_seconds = "DataFreshnessInSeconds",
        .dead_letter_queue_s3_configuration = "DeadLetterQueueS3Configuration",
        .storage_configuration = "StorageConfiguration",
    };
};
