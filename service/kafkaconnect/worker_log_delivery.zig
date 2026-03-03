const CloudWatchLogsLogDelivery = @import("cloud_watch_logs_log_delivery.zig").CloudWatchLogsLogDelivery;
const FirehoseLogDelivery = @import("firehose_log_delivery.zig").FirehoseLogDelivery;
const S3LogDelivery = @import("s3_log_delivery.zig").S3LogDelivery;

/// Workers can send worker logs to different destination types. This
/// configuration specifies the details of these destinations.
pub const WorkerLogDelivery = struct {
    /// Details about delivering logs to Amazon CloudWatch Logs.
    cloud_watch_logs: ?CloudWatchLogsLogDelivery = null,

    /// Details about delivering logs to Amazon Kinesis Data Firehose.
    firehose: ?FirehoseLogDelivery = null,

    /// Details about delivering logs to Amazon S3.
    s_3: ?S3LogDelivery = null,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
        .firehose = "firehose",
        .s_3 = "s3",
    };
};
