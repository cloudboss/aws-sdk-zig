/// An object that contains information about an event destination that sends
/// data to Amazon CloudWatch Logs.
pub const CloudWatchLogsDestination = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Identity and Access Management
    /// (IAM) role that is able to write event data to an Amazon CloudWatch
    /// destination.
    iam_role_arn: ?[]const u8 = null,

    /// The name of the Amazon CloudWatch Log Group that you want to record events
    /// in.
    log_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .iam_role_arn = "IamRoleArn",
        .log_group_arn = "LogGroupArn",
    };
};
