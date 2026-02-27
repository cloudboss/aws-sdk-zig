const CloudWatchLogs = @import("cloud_watch_logs.zig").CloudWatchLogs;
const Firehose = @import("firehose.zig").Firehose;
const S3 = @import("s3.zig").S3;

pub const BrokerLogs = struct {
    cloud_watch_logs: ?CloudWatchLogs,

    firehose: ?Firehose,

    s3: ?S3,

    pub const json_field_names = .{
        .cloud_watch_logs = "CloudWatchLogs",
        .firehose = "Firehose",
        .s3 = "S3",
    };
};
