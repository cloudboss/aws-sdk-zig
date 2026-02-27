/// Contains the destination configuration to use when publishing message
/// sending events.
pub const CloudWatchLogsDestination = struct {
    /// The Amazon Resource Name (ARN) of an Identity and Access Management role
    /// that is able to write event data to an Amazon CloudWatch destination.
    iam_role_arn: []const u8,

    /// The name of the Amazon CloudWatch log group that you want to record events
    /// in.
    log_group_arn: []const u8,

    pub const json_field_names = .{
        .iam_role_arn = "IamRoleArn",
        .log_group_arn = "LogGroupArn",
    };
};
