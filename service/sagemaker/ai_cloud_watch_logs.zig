/// CloudWatch log information for an AI benchmark or recommendation job.
pub const AICloudWatchLogs = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch log group.
    log_group_arn: ?[]const u8 = null,

    /// The name of the CloudWatch log stream.
    log_stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_group_arn = "LogGroupArn",
        .log_stream_name = "LogStreamName",
    };
};
