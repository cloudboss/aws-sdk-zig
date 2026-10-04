const DeadLetterQueueS3Configuration = @import("dead_letter_queue_s3_configuration.zig").DeadLetterQueueS3Configuration;
const S3TablesConfiguration = @import("s3_tables_configuration.zig").S3TablesConfiguration;

/// The configuration for delivery to streaming tables on Apache Iceberg.
/// Returned in ChannelDescription.
pub const S3TablesDestinationDescription = struct {
    /// The maximum age, in seconds, of undelivered data.
    data_freshness_in_seconds: i32,

    /// The dead-letter queue configuration for records that cannot be delivered.
    dead_letter_queue_s3_configuration: DeadLetterQueueS3Configuration,

    /// The list of streaming table configurations.
    s3_tables_configuration_list: []const S3TablesConfiguration,

    pub const json_field_names = .{
        .data_freshness_in_seconds = "DataFreshnessInSeconds",
        .dead_letter_queue_s3_configuration = "DeadLetterQueueS3Configuration",
        .s3_tables_configuration_list = "S3TablesConfigurationList",
    };
};
