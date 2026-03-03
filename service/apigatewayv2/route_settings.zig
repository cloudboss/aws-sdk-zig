const LoggingLevel = @import("logging_level.zig").LoggingLevel;

/// Represents a collection of route settings.
pub const RouteSettings = struct {
    /// Specifies whether (true) or not (false) data trace logging is enabled for
    /// this route. This property affects the log entries pushed to Amazon
    /// CloudWatch Logs. Supported only for WebSocket APIs.
    data_trace_enabled: ?bool = null,

    /// Specifies whether detailed metrics are enabled.
    detailed_metrics_enabled: ?bool = null,

    /// Specifies the logging level for this route: INFO, ERROR, or OFF. This
    /// property affects the log entries pushed to Amazon CloudWatch Logs. Supported
    /// only for WebSocket APIs.
    logging_level: ?LoggingLevel = null,

    /// Specifies the throttling burst limit.
    throttling_burst_limit: ?i32 = null,

    /// Specifies the throttling rate limit.
    throttling_rate_limit: ?f64 = null,

    pub const json_field_names = .{
        .data_trace_enabled = "DataTraceEnabled",
        .detailed_metrics_enabled = "DetailedMetricsEnabled",
        .logging_level = "LoggingLevel",
        .throttling_burst_limit = "ThrottlingBurstLimit",
        .throttling_rate_limit = "ThrottlingRateLimit",
    };
};
