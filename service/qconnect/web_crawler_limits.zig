/// The configuration of crawl limits for the web URLs.
pub const WebCrawlerLimits = struct {
    /// Rate of web URLs retrieved per minute.
    rate_limit: ?i32,

    pub const json_field_names = .{
        .rate_limit = "rateLimit",
    };
};
