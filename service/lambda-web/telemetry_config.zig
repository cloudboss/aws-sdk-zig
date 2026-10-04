const LoggingConfig = @import("logging_config.zig").LoggingConfig;

/// The telemetry configuration for a web function revision.
pub const TelemetryConfig = struct {
    /// The logging configuration for the web function.
    logging_config: ?LoggingConfig = null,

    pub const json_field_names = .{
        .logging_config = "loggingConfig",
    };
};
