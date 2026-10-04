const CloudWatchLogs = @import("cloud_watch_logs.zig").CloudWatchLogs;
const Firehose = @import("firehose.zig").Firehose;
const S3 = @import("s3.zig").S3;

/// Configuration for the destinations to which the channel publishes
/// operational logs.
pub const ChannelLoggingInfo = struct {
    /// Details of the CloudWatch Logs destination for Channel logs.
    cloud_watch_logs: ?CloudWatchLogs = null,

    /// Details of the Kinesis Data Firehose delivery stream that is the destination
    /// for Channel logs.
    firehose: ?Firehose = null,

    /// Details of the Amazon S3 destination for Channel logs.
    s3: ?S3 = null,

    pub const json_field_names = .{
        .cloud_watch_logs = "CloudWatchLogs",
        .firehose = "Firehose",
        .s3 = "S3",
    };
};
