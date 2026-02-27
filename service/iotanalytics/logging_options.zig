const LoggingLevel = @import("logging_level.zig").LoggingLevel;

/// Information about logging options.
pub const LoggingOptions = struct {
    /// If true, logging is enabled for IoT Analytics.
    enabled: bool = false,

    /// The logging level. Currently, only ERROR is supported.
    level: LoggingLevel,

    /// The ARN of the role that grants permission to IoT Analytics to perform
    /// logging.
    role_arn: []const u8,

    pub const json_field_names = .{
        .enabled = "enabled",
        .level = "level",
        .role_arn = "roleArn",
    };
};
