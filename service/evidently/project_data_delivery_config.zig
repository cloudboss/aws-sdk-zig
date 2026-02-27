const CloudWatchLogsDestinationConfig = @import("cloud_watch_logs_destination_config.zig").CloudWatchLogsDestinationConfig;
const S3DestinationConfig = @import("s3_destination_config.zig").S3DestinationConfig;

/// A structure that contains information about where Evidently is to store
/// evaluation events for longer term storage.
pub const ProjectDataDeliveryConfig = struct {
    /// If the project stores evaluation events in CloudWatch Logs, this structure
    /// stores the log group name.
    cloud_watch_logs: ?CloudWatchLogsDestinationConfig,

    /// If the project stores evaluation events in an Amazon S3 bucket, this
    /// structure stores the bucket name and bucket prefix.
    s_3_destination: ?S3DestinationConfig,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
        .s_3_destination = "s3Destination",
    };
};
