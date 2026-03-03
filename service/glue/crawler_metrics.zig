/// Metrics for a specified crawler.
pub const CrawlerMetrics = struct {
    /// The name of the crawler.
    crawler_name: ?[]const u8 = null,

    /// The duration of the crawler's most recent run, in seconds.
    last_runtime_seconds: f64 = 0,

    /// The median duration of this crawler's runs, in seconds.
    median_runtime_seconds: f64 = 0,

    /// True if the crawler is still estimating how long it will take to complete
    /// this run.
    still_estimating: bool = false,

    /// The number of tables created by this crawler.
    tables_created: i32 = 0,

    /// The number of tables deleted by this crawler.
    tables_deleted: i32 = 0,

    /// The number of tables updated by this crawler.
    tables_updated: i32 = 0,

    /// The estimated time left to complete a running crawl.
    time_left_seconds: f64 = 0,

    pub const json_field_names = .{
        .crawler_name = "CrawlerName",
        .last_runtime_seconds = "LastRuntimeSeconds",
        .median_runtime_seconds = "MedianRuntimeSeconds",
        .still_estimating = "StillEstimating",
        .tables_created = "TablesCreated",
        .tables_deleted = "TablesDeleted",
        .tables_updated = "TablesUpdated",
        .time_left_seconds = "TimeLeftSeconds",
    };
};
