const ApplicationLogLevel = @import("application_log_level.zig").ApplicationLogLevel;
const LogFormat = @import("log_format.zig").LogFormat;
const SystemLogLevel = @import("system_log_level.zig").SystemLogLevel;

/// The function's Amazon CloudWatch Logs configuration settings.
pub const LoggingConfig = struct {
    /// Set this property to filter the application logs for your function that
    /// Lambda sends to CloudWatch. Lambda only sends application logs at the
    /// selected level of detail and lower, where `TRACE` is the highest level and
    /// `FATAL` is the lowest.
    application_log_level: ?ApplicationLogLevel = null,

    /// The format in which Lambda sends your function's application and system logs
    /// to CloudWatch. Select between plain text and structured JSON.
    log_format: ?LogFormat = null,

    /// The name of the Amazon CloudWatch log group the function sends logs to. By
    /// default, Lambda functions send logs to a default log group named
    /// `/aws/lambda/<function name>`. To use a different log group, enter an
    /// existing log group or enter a new log group name.
    log_group: ?[]const u8 = null,

    /// Set this property to filter the system logs for your function that Lambda
    /// sends to CloudWatch. Lambda only sends system logs at the selected level of
    /// detail and lower, where `DEBUG` is the highest level and `WARN` is the
    /// lowest.
    system_log_level: ?SystemLogLevel = null,

    pub const json_field_names = .{
        .application_log_level = "ApplicationLogLevel",
        .log_format = "LogFormat",
        .log_group = "LogGroup",
        .system_log_level = "SystemLogLevel",
    };
};
