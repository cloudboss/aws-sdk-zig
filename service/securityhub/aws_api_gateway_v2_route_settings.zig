/// Contains route settings for a stage.
pub const AwsApiGatewayV2RouteSettings = struct {
    /// Indicates whether data trace logging is enabled. Data trace logging affects
    /// the log
    /// entries that are pushed to CloudWatch Logs. Supported only for WebSocket
    /// APIs.
    data_trace_enabled: ?bool,

    /// Indicates whether detailed metrics are enabled.
    detailed_metrics_enabled: ?bool,

    /// The logging level. The logging level affects the log entries that are pushed
    /// to
    /// CloudWatch Logs. Supported only for WebSocket APIs.
    ///
    /// If the logging level is `ERROR`, then the logs only include error-level
    /// entries.
    ///
    /// If the logging level is `INFO`, then the logs include both `ERROR`
    /// events and extra informational events.
    ///
    /// Valid values: `OFF` | `ERROR` | `INFO`
    logging_level: ?[]const u8,

    /// The throttling burst limit.
    throttling_burst_limit: ?i32,

    /// The throttling rate limit.
    throttling_rate_limit: ?f64,

    pub const json_field_names = .{
        .data_trace_enabled = "DataTraceEnabled",
        .detailed_metrics_enabled = "DetailedMetricsEnabled",
        .logging_level = "LoggingLevel",
        .throttling_burst_limit = "ThrottlingBurstLimit",
        .throttling_rate_limit = "ThrottlingRateLimit",
    };
};
