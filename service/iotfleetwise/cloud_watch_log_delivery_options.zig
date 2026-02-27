const LogType = @import("log_type.zig").LogType;

/// The log delivery option to send data to Amazon CloudWatch Logs.
pub const CloudWatchLogDeliveryOptions = struct {
    /// The Amazon CloudWatch Logs group the operation sends data to.
    log_group_name: ?[]const u8,

    /// The type of log to send data to Amazon CloudWatch Logs.
    log_type: LogType,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
        .log_type = "logType",
    };
};
