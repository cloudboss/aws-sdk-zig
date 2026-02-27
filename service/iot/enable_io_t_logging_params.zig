const LogLevel = @import("log_level.zig").LogLevel;

/// Parameters used when defining a mitigation action that enable Amazon Web
/// Services IoT Core logging.
pub const EnableIoTLoggingParams = struct {
    /// Specifies the type of information to be logged.
    log_level: LogLevel,

    /// The Amazon Resource Name (ARN) of the IAM role used for logging.
    role_arn_for_logging: []const u8,

    pub const json_field_names = .{
        .log_level = "logLevel",
        .role_arn_for_logging = "roleArnForLogging",
    };
};
