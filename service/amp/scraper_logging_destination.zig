const CloudWatchLogDestination = @import("cloud_watch_log_destination.zig").CloudWatchLogDestination;

/// The destination where scraper logs are sent.
pub const ScraperLoggingDestination = union(enum) {
    /// The CloudWatch Logs configuration for the scraper logging destination.
    cloud_watch_logs: ?CloudWatchLogDestination,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
    };
};
