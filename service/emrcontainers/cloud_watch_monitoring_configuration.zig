/// A configuration for CloudWatch monitoring. You can configure your jobs to
/// send log
/// information to CloudWatch Logs.
pub const CloudWatchMonitoringConfiguration = struct {
    /// The name of the log group for log publishing.
    log_group_name: []const u8,

    /// The specified name prefix for log streams.
    log_stream_name_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
        .log_stream_name_prefix = "logStreamNamePrefix",
    };
};
