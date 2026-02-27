/// Configuration for the CloudWatch log group destination of user pool detailed
/// activity
/// logging, or of user activity log export with threat protection.
pub const CloudWatchLogsConfigurationType = struct {
    /// The Amazon Resource Name (arn) of a CloudWatch Logs log group where your
    /// user pool sends logs.
    /// The log group must not be encrypted with Key Management Service and must be
    /// in the same Amazon Web Services account
    /// as your user pool.
    ///
    /// To send logs to log groups with a resource policy of a size greater than
    /// 5120
    /// characters, configure a log group with a path that starts with
    /// `/aws/vendedlogs`. For more information, see [Enabling
    /// logging from certain Amazon Web Services
    /// services](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html).
    log_group_arn: ?[]const u8,

    pub const json_field_names = .{
        .log_group_arn = "LogGroupArn",
    };
};
