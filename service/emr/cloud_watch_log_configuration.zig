const aws = @import("aws");

/// Holds CloudWatch log configuration settings and metadata that specify
/// settings like log files to monitor and where to send them.
pub const CloudWatchLogConfiguration = struct {
    /// Specifies if CloudWatch logging is enabled.
    enabled: bool,

    /// The ARN of the encryption key used to encrypt the logs.
    encryption_key_arn: ?[]const u8 = null,

    /// The name of the CloudWatch log group where logs are published.
    log_group_name: ?[]const u8 = null,

    /// The prefix of the log stream name.
    log_stream_name_prefix: ?[]const u8 = null,

    /// A map of log types to file names for publishing logs to the standard output
    /// or standard error streams for CloudWatch. Valid log types include STEP_LOGS,
    /// SPARK_DRIVER, and SPARK_EXECUTOR. Valid file names for each type include
    /// STDOUT and STDERR.
    log_types: ?[]const aws.map.MapEntry([]const []const u8) = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .encryption_key_arn = "EncryptionKeyArn",
        .log_group_name = "LogGroupName",
        .log_stream_name_prefix = "LogStreamNamePrefix",
        .log_types = "LogTypes",
    };
};
