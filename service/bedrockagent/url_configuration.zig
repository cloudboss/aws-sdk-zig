const SeedUrl = @import("seed_url.zig").SeedUrl;

/// The configuration of web URLs that you want to crawl. You should be
/// authorized to crawl the URLs.
pub const UrlConfiguration = struct {
    /// One or more seed or starting point URLs.
    seed_urls: ?[]const SeedUrl = null,

    pub const json_field_names = .{
        .seed_urls = "seedUrls",
    };
};
