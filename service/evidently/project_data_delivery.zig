const CloudWatchLogsDestination = @import("cloud_watch_logs_destination.zig").CloudWatchLogsDestination;
const S3Destination = @import("s3_destination.zig").S3Destination;

/// A structure that contains information about where Evidently is to store
/// evaluation events for longer term storage.
pub const ProjectDataDelivery = struct {
    /// If the project stores evaluation events in CloudWatch Logs, this structure
    /// stores the log group name.
    cloud_watch_logs: ?CloudWatchLogsDestination,

    /// If the project stores evaluation events in an Amazon S3 bucket, this
    /// structure stores the bucket name and bucket prefix.
    s_3_destination: ?S3Destination,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
        .s_3_destination = "s3Destination",
    };
};
