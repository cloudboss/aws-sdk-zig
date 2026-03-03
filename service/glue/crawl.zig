const CrawlState = @import("crawl_state.zig").CrawlState;

/// The details of a crawl in the workflow.
pub const Crawl = struct {
    /// The date and time on which the crawl completed.
    completed_on: ?i64 = null,

    /// The error message associated with the crawl.
    error_message: ?[]const u8 = null,

    /// The log group associated with the crawl.
    log_group: ?[]const u8 = null,

    /// The log stream associated with the crawl.
    log_stream: ?[]const u8 = null,

    /// The date and time on which the crawl started.
    started_on: ?i64 = null,

    /// The state of the crawler.
    state: ?CrawlState = null,

    pub const json_field_names = .{
        .completed_on = "CompletedOn",
        .error_message = "ErrorMessage",
        .log_group = "LogGroup",
        .log_stream = "LogStream",
        .started_on = "StartedOn",
        .state = "State",
    };
};
