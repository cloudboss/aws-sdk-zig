const aws = @import("aws");

/// The CloudWatch Logs configuration for a session.
pub const SessionCloudWatchLoggingConfiguration = struct {
    /// Whether CloudWatch Logs is enabled for the session.
    enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the logs
    /// published to CloudWatch Logs.
    encryption_key_arn: ?[]const u8 = null,

    /// The name of the log group where session logs are published.
    log_group: ?[]const u8 = null,

    /// The prefix applied to the log stream name where session logs are published.
    log_stream_name_prefix: ?[]const u8 = null,

    /// A map of log component names (for example, `SPARK_DRIVER`, `SPARK_EXECUTOR`)
    /// to the list of log types to publish for that component (for example,
    /// `stdout`, `stderr`).
    log_types: ?[]const aws.map.MapEntry([]const []const u8) = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .encryption_key_arn = "EncryptionKeyArn",
        .log_group = "LogGroup",
        .log_stream_name_prefix = "LogStreamNamePrefix",
        .log_types = "LogTypes",
    };
};
