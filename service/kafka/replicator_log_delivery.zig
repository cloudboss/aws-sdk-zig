const ReplicatorCloudWatchLogs = @import("replicator_cloud_watch_logs.zig").ReplicatorCloudWatchLogs;
const ReplicatorFirehose = @import("replicator_firehose.zig").ReplicatorFirehose;
const ReplicatorS3 = @import("replicator_s3.zig").ReplicatorS3;

/// Configuration for replicator log delivery.
pub const ReplicatorLogDelivery = struct {
    /// Configuration for CloudWatch Logs delivery.
    cloud_watch_logs: ?ReplicatorCloudWatchLogs = null,

    /// Configuration for Firehose delivery.
    firehose: ?ReplicatorFirehose = null,

    /// Configuration for S3 delivery.
    s3: ?ReplicatorS3 = null,

    pub const json_field_names = .{
        .cloud_watch_logs = "CloudWatchLogs",
        .firehose = "Firehose",
        .s3 = "S3",
    };
};
