const LogLevel = @import("log_level.zig").LogLevel;

/// Describes the logging options payload.
pub const LoggingOptionsPayload = struct {
    /// The log level.
    log_level: ?LogLevel = null,

    /// The ARN of the IAM role that grants access.
    role_arn: []const u8,

    pub const json_field_names = .{
        .log_level = "logLevel",
        .role_arn = "roleArn",
    };
};
