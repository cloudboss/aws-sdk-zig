const WebCrawlerMode = @import("web_crawler_mode.zig").WebCrawlerMode;

/// Provides the configuration information for the seed or starting point URLs
/// to
/// crawl.
///
/// *When selecting websites to index, you must adhere to the [Amazon Acceptable
/// Use Policy](https://aws.amazon.com/aup/) and all
/// other Amazon terms. Remember that you must only use Amazon Kendra Web
/// Crawler
/// to index your own web pages, or web pages that you have authorization to
/// index.*
pub const SeedUrlConfiguration = struct {
    /// The list of seed or starting point URLs of the websites you want to crawl.
    ///
    /// The list can include a maximum of 100 seed URLs.
    seed_urls: []const []const u8,

    /// You can choose one of the following modes:
    ///
    /// * `HOST_ONLY`—crawl only the website host names. For
    /// example, if the seed URL is "abc.example.com", then only URLs with host name
    /// "abc.example.com" are crawled.
    ///
    /// * `SUBDOMAINS`—crawl the website host names with subdomains.
    /// For example, if the seed URL is "abc.example.com", then "a.abc.example.com"
    /// and
    /// "b.abc.example.com" are also crawled.
    ///
    /// * `EVERYTHING`—crawl the website host names with subdomains
    /// and other domains that the web pages link to.
    ///
    /// The default mode is set to `HOST_ONLY`.
    web_crawler_mode: ?WebCrawlerMode = null,

    pub const json_field_names = .{
        .seed_urls = "SeedUrls",
        .web_crawler_mode = "WebCrawlerMode",
    };
};
