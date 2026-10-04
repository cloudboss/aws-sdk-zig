const CloudWatchLogs = @import("cloud_watch_logs.zig").CloudWatchLogs;
const Firehose = @import("firehose.zig").Firehose;
const S3 = @import("s3.zig").S3;

/// The authorizer logs configuration for this MSK cluster.
pub const AuthorizerLogs = struct {
    /// Details of the CloudWatch Logs destination for authorizer logs.
    cloud_watch_logs: ?CloudWatchLogs = null,

    /// Details of the Kinesis Data Firehose delivery stream that is the destination
    /// for authorizer logs.
    firehose: ?Firehose = null,

    /// Details of the Amazon S3 destination for authorizer logs.
    s3: ?S3 = null,

    pub const json_field_names = .{
        .cloud_watch_logs = "CloudWatchLogs",
        .firehose = "Firehose",
        .s3 = "S3",
    };
};
