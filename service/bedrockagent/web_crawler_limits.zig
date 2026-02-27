/// The rate limits for the URLs that you want to crawl. You should be
/// authorized to crawl the URLs.
pub const WebCrawlerLimits = struct {
    /// The max number of web pages crawled from your source URLs, up to 25,000
    /// pages. If the web pages exceed this limit, the data source sync will fail
    /// and no web pages will be ingested.
    max_pages: ?i32,

    /// The max rate at which pages are crawled, up to 300 per minute per host.
    rate_limit: ?i32,

    pub const json_field_names = .{
        .max_pages = "maxPages",
        .rate_limit = "rateLimit",
    };
};
