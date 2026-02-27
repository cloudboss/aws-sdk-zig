pub const CloudWatchLogsLogGroup = struct {
    /// The ARN of the the CloudWatch log group to which you want your logs emitted
    /// to. The ARN
    /// must end with `:*`
    log_group_arn: ?[]const u8,

    pub const json_field_names = .{
        .log_group_arn = "logGroupArn",
    };
};
