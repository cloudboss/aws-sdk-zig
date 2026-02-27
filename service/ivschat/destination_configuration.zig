const CloudWatchLogsDestinationConfiguration = @import("cloud_watch_logs_destination_configuration.zig").CloudWatchLogsDestinationConfiguration;
const FirehoseDestinationConfiguration = @import("firehose_destination_configuration.zig").FirehoseDestinationConfiguration;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;

/// A complex type that describes a location where chat logs will be stored.
/// Each member
/// represents the configuration of one log destination. For logging, you define
/// only one type of
/// destination (for CloudWatch Logs, Kinesis Firehose, or S3).
pub const DestinationConfiguration = union(enum) {
    /// An Amazon CloudWatch Logs destination configuration where chat activity will
    /// be
    /// logged.
    cloud_watch_logs: ?CloudWatchLogsDestinationConfiguration,
    /// An Amazon Kinesis Data Firehose destination configuration where chat
    /// activity will be
    /// logged.
    firehose: ?FirehoseDestinationConfiguration,
    /// An Amazon S3 destination configuration where chat activity will be logged.
    s_3: ?S3DestinationConfiguration,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
        .firehose = "firehose",
        .s_3 = "s3",
    };
};
