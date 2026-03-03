const CloudwatchLogsLogDestinationParameters = @import("cloudwatch_logs_log_destination_parameters.zig").CloudwatchLogsLogDestinationParameters;
const FirehoseLogDestinationParameters = @import("firehose_log_destination_parameters.zig").FirehoseLogDestinationParameters;
const IncludeExecutionDataOption = @import("include_execution_data_option.zig").IncludeExecutionDataOption;
const LogLevel = @import("log_level.zig").LogLevel;
const S3LogDestinationParameters = @import("s3_log_destination_parameters.zig").S3LogDestinationParameters;

/// Specifies the logging configuration settings for the pipe.
///
/// When you call `UpdatePipe`, EventBridge updates the fields in the
/// `PipeLogConfigurationParameters` object atomically as one and overrides
/// existing values. This is by design. If you don't specify an optional field
/// in any of the
/// Amazon Web Services service parameters objects
/// (`CloudwatchLogsLogDestinationParameters`,
/// `FirehoseLogDestinationParameters`, or
/// `S3LogDestinationParameters`), EventBridge sets that field to its
/// system-default value during the update.
///
/// For example, suppose when you created the pipe you specified a Firehose
/// stream
/// log destination. You then update the pipe to add an Amazon S3 log
/// destination. In
/// addition to specifying the `S3LogDestinationParameters` for the new log
/// destination, you must also specify the fields in the
/// `FirehoseLogDestinationParameters` object in order to retain the Firehose
/// stream log destination.
///
/// For more information on generating pipe log records, see [Log EventBridge
/// Pipes](eventbridge/latest/userguide/eb-pipes-logs.html) in the *Amazon
/// EventBridge User Guide*.
pub const PipeLogConfigurationParameters = struct {
    /// The Amazon CloudWatch Logs logging configuration settings for the pipe.
    cloudwatch_logs_log_destination: ?CloudwatchLogsLogDestinationParameters = null,

    /// The Amazon Data Firehose logging configuration settings for the pipe.
    firehose_log_destination: ?FirehoseLogDestinationParameters = null,

    /// Specify `ALL` to include the execution data (specifically, the
    /// `payload`, `awsRequest`, and `awsResponse` fields) in
    /// the log messages for this pipe.
    ///
    /// This applies to all log destinations for the pipe.
    ///
    /// For more information, see [Including execution data in
    /// logs](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes-logs.html#eb-pipes-logs-execution-data) in the *Amazon EventBridge User
    /// Guide*.
    ///
    /// By default, execution data is not included.
    include_execution_data: ?[]const IncludeExecutionDataOption = null,

    /// The level of logging detail to include. This applies to all log destinations
    /// for the pipe.
    ///
    /// For more information, see [Specifying
    /// EventBridge Pipes log
    /// level](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes-logs.html#eb-pipes-logs-level) in the *Amazon EventBridge User
    /// Guide*.
    level: LogLevel,

    /// The Amazon S3 logging configuration settings for the pipe.
    s3_log_destination: ?S3LogDestinationParameters = null,

    pub const json_field_names = .{
        .cloudwatch_logs_log_destination = "CloudwatchLogsLogDestination",
        .firehose_log_destination = "FirehoseLogDestination",
        .include_execution_data = "IncludeExecutionData",
        .level = "Level",
        .s3_log_destination = "S3LogDestination",
    };
};
