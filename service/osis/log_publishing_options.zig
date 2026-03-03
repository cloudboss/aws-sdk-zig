const CloudWatchLogDestination = @import("cloud_watch_log_destination.zig").CloudWatchLogDestination;

/// Container for the values required to configure logging for the pipeline. If
/// you don't
/// specify these values, OpenSearch Ingestion will not publish logs from your
/// application to
/// CloudWatch Logs.
pub const LogPublishingOptions = struct {
    /// The destination for OpenSearch Ingestion logs sent to Amazon CloudWatch
    /// Logs. This
    /// parameter is required if `IsLoggingEnabled` is set to `true`.
    cloud_watch_log_destination: ?CloudWatchLogDestination = null,

    /// Whether logs should be published.
    is_logging_enabled: ?bool = null,

    pub const json_field_names = .{
        .cloud_watch_log_destination = "CloudWatchLogDestination",
        .is_logging_enabled = "IsLoggingEnabled",
    };
};
