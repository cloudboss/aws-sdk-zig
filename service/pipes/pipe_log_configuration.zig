const CloudwatchLogsLogDestination = @import("cloudwatch_logs_log_destination.zig").CloudwatchLogsLogDestination;
const FirehoseLogDestination = @import("firehose_log_destination.zig").FirehoseLogDestination;
const IncludeExecutionDataOption = @import("include_execution_data_option.zig").IncludeExecutionDataOption;
const LogLevel = @import("log_level.zig").LogLevel;
const S3LogDestination = @import("s3_log_destination.zig").S3LogDestination;

/// The logging configuration settings for the pipe.
pub const PipeLogConfiguration = struct {
    /// The Amazon CloudWatch Logs logging configuration settings for the pipe.
    cloudwatch_logs_log_destination: ?CloudwatchLogsLogDestination = null,

    /// The Amazon Data Firehose logging configuration settings for the pipe.
    firehose_log_destination: ?FirehoseLogDestination = null,

    /// Whether the execution data (specifically, the `payload`,
    /// `awsRequest`, and `awsResponse` fields) is included in the log
    /// messages for this pipe.
    ///
    /// This applies to all log destinations for the pipe.
    ///
    /// For more information, see [Including execution data in
    /// logs](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes-logs.html#eb-pipes-logs-execution-data) in the *Amazon EventBridge User
    /// Guide*.
    include_execution_data: ?[]const IncludeExecutionDataOption = null,

    /// The level of logging detail to include. This applies to all log destinations
    /// for the pipe.
    level: ?LogLevel = null,

    /// The Amazon S3 logging configuration settings for the pipe.
    s3_log_destination: ?S3LogDestination = null,

    pub const json_field_names = .{
        .cloudwatch_logs_log_destination = "CloudwatchLogsLogDestination",
        .firehose_log_destination = "FirehoseLogDestination",
        .include_execution_data = "IncludeExecutionData",
        .level = "Level",
        .s3_log_destination = "S3LogDestination",
    };
};
