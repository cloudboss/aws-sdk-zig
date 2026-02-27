const CrawlerHistoryState = @import("crawler_history_state.zig").CrawlerHistoryState;

/// Contains the information for a run of a crawler.
pub const CrawlerHistory = struct {
    /// A UUID identifier for each crawl.
    crawl_id: ?[]const u8,

    /// The number of data processing units (DPU) used in hours for the crawl.
    dpu_hour: f64 = 0,

    /// The date and time on which the crawl ended.
    end_time: ?i64,

    /// If an error occurred, the error message associated with the crawl.
    error_message: ?[]const u8,

    /// The log group associated with the crawl.
    log_group: ?[]const u8,

    /// The log stream associated with the crawl.
    log_stream: ?[]const u8,

    /// The prefix for a CloudWatch message about this crawl.
    message_prefix: ?[]const u8,

    /// The date and time on which the crawl started.
    start_time: ?i64,

    /// The state of the crawl.
    state: ?CrawlerHistoryState,

    /// A run summary for the specific crawl in JSON. Contains the catalog tables
    /// and partitions that were added, updated, or deleted.
    summary: ?[]const u8,

    pub const json_field_names = .{
        .crawl_id = "CrawlId",
        .dpu_hour = "DPUHour",
        .end_time = "EndTime",
        .error_message = "ErrorMessage",
        .log_group = "LogGroup",
        .log_stream = "LogStream",
        .message_prefix = "MessagePrefix",
        .start_time = "StartTime",
        .state = "State",
        .summary = "Summary",
    };
};
