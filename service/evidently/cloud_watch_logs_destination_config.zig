/// A structure containing the CloudWatch Logs log group where the project
/// stores evaluation events.
pub const CloudWatchLogsDestinationConfig = struct {
    /// The name of the log group where the project stores evaluation events.
    log_group: ?[]const u8,

    pub const json_field_names = .{
        .log_group = "logGroup",
    };
};
