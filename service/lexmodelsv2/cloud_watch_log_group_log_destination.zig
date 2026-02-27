/// The Amazon CloudWatch Logs log group where the text and metadata logs are
/// delivered. The log group must exist before you enable logging.
pub const CloudWatchLogGroupLogDestination = struct {
    /// The Amazon Resource Name (ARN) of the log group where text and
    /// metadata logs are delivered.
    cloud_watch_log_group_arn: []const u8,

    /// The prefix of the log stream name within the log group that you
    /// specified
    log_prefix: []const u8,

    pub const json_field_names = .{
        .cloud_watch_log_group_arn = "cloudWatchLogGroupArn",
        .log_prefix = "logPrefix",
    };
};
