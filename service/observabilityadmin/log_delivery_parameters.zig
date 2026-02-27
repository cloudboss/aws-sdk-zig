const LogType = @import("log_type.zig").LogType;

/// Configuration parameters for Amazon Bedrock AgentCore logging, including
/// `logType` settings.
pub const LogDeliveryParameters = struct {
    /// The type of log that the source is sending.
    log_types: ?[]const LogType,

    pub const json_field_names = .{
        .log_types = "LogTypes",
    };
};
