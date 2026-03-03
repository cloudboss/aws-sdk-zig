/// The Amazon CloudWatch Logs log group for the simulation. For more
/// information about log groups, see [Working with log
/// groups and log
/// streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html) in the *Amazon CloudWatch Logs User Guide*.
pub const CloudWatchLogsLogGroup = struct {
    /// The Amazon Resource Name (ARN) of the Amazon CloudWatch Logs log group for
    /// the simulation.
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
    /// in the *Amazon Web Services General Reference*. For more information about
    /// log groups, see [Working with log
    /// groups and log
    /// streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html) in the *Amazon CloudWatch Logs User Guide*.
    log_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_group_arn = "LogGroupArn",
    };
};
