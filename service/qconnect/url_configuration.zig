const SeedUrl = @import("seed_url.zig").SeedUrl;

/// The configuration of the URL/URLs for the web content that you want to
/// crawl. You should be authorized to crawl the URLs.
pub const UrlConfiguration = struct {
    /// List of URLs for crawling.
    seed_urls: ?[]const SeedUrl = null,

    pub const json_field_names = .{
        .seed_urls = "seedUrls",
    };
};
