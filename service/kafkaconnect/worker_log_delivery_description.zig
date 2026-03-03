const CloudWatchLogsLogDeliveryDescription = @import("cloud_watch_logs_log_delivery_description.zig").CloudWatchLogsLogDeliveryDescription;
const FirehoseLogDeliveryDescription = @import("firehose_log_delivery_description.zig").FirehoseLogDeliveryDescription;
const S3LogDeliveryDescription = @import("s3_log_delivery_description.zig").S3LogDeliveryDescription;

/// Workers can send worker logs to different destination types. This
/// configuration specifies the details of these destinations.
pub const WorkerLogDeliveryDescription = struct {
    /// Details about delivering logs to Amazon CloudWatch Logs.
    cloud_watch_logs: ?CloudWatchLogsLogDeliveryDescription = null,

    /// Details about delivering logs to Amazon Kinesis Data Firehose.
    firehose: ?FirehoseLogDeliveryDescription = null,

    /// Details about delivering logs to Amazon S3.
    s_3: ?S3LogDeliveryDescription = null,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
        .firehose = "firehose",
        .s_3 = "s3",
    };
};
