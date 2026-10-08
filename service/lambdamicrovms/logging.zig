const CloudWatchLogging = @import("cloud_watch_logging.zig").CloudWatchLogging;
const LoggingDisabled = @import("logging_disabled.zig").LoggingDisabled;

/// Configuration for MicroVM logging output. Specify exactly one: cloudWatch to
/// enable CloudWatch logging, or disabled to turn off logging.
pub const Logging = union(enum) {
    /// Configuration for sending logs to Amazon CloudWatch Logs.
    cloud_watch: ?CloudWatchLogging,
    /// Specifies that logging is disabled.
    disabled: ?LoggingDisabled,

    pub const json_field_names = .{
        .cloud_watch = "cloudWatch",
        .disabled = "disabled",
    };
};
