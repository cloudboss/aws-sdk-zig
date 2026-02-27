/// Specifies a CloudWatch Logs location where chat logs will be stored.
pub const CloudWatchLogsDestinationConfiguration = struct {
    /// Name of the Amazon Cloudwatch Logs destination where chat activity will be
    /// logged.
    log_group_name: []const u8,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
    };
};
