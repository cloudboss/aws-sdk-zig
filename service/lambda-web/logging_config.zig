const ApplicationLogLevel = @import("application_log_level.zig").ApplicationLogLevel;
const SystemLogLevel = @import("system_log_level.zig").SystemLogLevel;

/// The logging configuration for a web function revision.
pub const LoggingConfig = struct {
    /// The log level for application logs emitted by the web function. If you don't
    /// specify a value, the default is `INFO`, and this default is returned in the
    /// response.
    application_log_level: ?ApplicationLogLevel = null,

    /// The name of the Amazon CloudWatch Logs log group the web function sends logs
    /// to. If you don't specify a value, the default is
    /// `/aws/lambda/web/{functionName}`, and this default is returned in the
    /// response.
    log_group: ?[]const u8 = null,

    /// The log level for system logs emitted by the Lambda runtime. If you don't
    /// specify a value, the default is `INFO`, and this default is returned in the
    /// response.
    system_log_level: ?SystemLogLevel = null,

    pub const json_field_names = .{
        .application_log_level = "applicationLogLevel",
        .log_group = "logGroup",
        .system_log_level = "systemLogLevel",
    };
};
