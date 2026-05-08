/// CloudWatch Logs destination for batch evaluation results
pub const CloudWatchOutputConfig = struct {
    /// The name of the CloudWatch log group where evaluation results will be
    /// written.
    log_group_name: []const u8,

    /// The name of the CloudWatch log stream where evaluation results will be
    /// written.
    log_stream_name: []const u8,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
        .log_stream_name = "logStreamName",
    };
};
