const LastCrawlStatus = @import("last_crawl_status.zig").LastCrawlStatus;

/// Status and error information about the most recent crawl.
pub const LastCrawlInfo = struct {
    /// If an error occurred, the error information about the last crawl.
    error_message: ?[]const u8 = null,

    /// The log group for the last crawl.
    log_group: ?[]const u8 = null,

    /// The log stream for the last crawl.
    log_stream: ?[]const u8 = null,

    /// The prefix for a message about this crawl.
    message_prefix: ?[]const u8 = null,

    /// The time at which the crawl started.
    start_time: ?i64 = null,

    /// Status of the last crawl.
    status: ?LastCrawlStatus = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .log_group = "LogGroup",
        .log_stream = "LogStream",
        .message_prefix = "MessagePrefix",
        .start_time = "StartTime",
        .status = "Status",
    };
};
