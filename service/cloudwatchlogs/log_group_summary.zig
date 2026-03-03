const LogGroupClass = @import("log_group_class.zig").LogGroupClass;

/// This structure contains information about one log group in your account.
pub const LogGroupSummary = struct {
    /// The Amazon Resource Name (ARN) of the log group.
    log_group_arn: ?[]const u8 = null,

    /// The log group class for this log group. For details about the features
    /// supported by each
    /// log group class, see [Log
    /// classes](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch_Logs_Log_Classes.html)
    log_group_class: ?LogGroupClass = null,

    /// The name of the log group.
    log_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_group_arn = "logGroupArn",
        .log_group_class = "logGroupClass",
        .log_group_name = "logGroupName",
    };
};
