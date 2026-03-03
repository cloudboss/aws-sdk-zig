const aws = @import("aws");

/// Configuration settings for delivering logs to Amazon CloudWatch log groups.
pub const CloudWatchLoggingConfiguration = struct {
    /// Enables CloudWatch logging.
    enabled: bool,

    /// The name of the log group in Amazon CloudWatch Logs where you want to
    /// publish
    /// your logs.
    log_group: ?[]const u8 = null,

    /// Prefix for the CloudWatch log stream name.
    log_stream_name_prefix: ?[]const u8 = null,

    /// The types of logs that you want to publish to CloudWatch.
    log_types: ?[]const aws.map.MapEntry([]const []const u8) = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .log_group = "LogGroup",
        .log_stream_name_prefix = "LogStreamNamePrefix",
        .log_types = "LogTypes",
    };
};
