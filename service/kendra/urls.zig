const SeedUrlConfiguration = @import("seed_url_configuration.zig").SeedUrlConfiguration;
const SiteMapsConfiguration = @import("site_maps_configuration.zig").SiteMapsConfiguration;

/// Provides the configuration information of the URLs to crawl.
///
/// You can only crawl websites that use the secure communication protocol,
/// Hypertext
/// Transfer Protocol Secure (HTTPS). If you receive an error when crawling a
/// website, it
/// could be that the website is blocked from crawling.
///
/// *When selecting websites to index, you must adhere to the [Amazon Acceptable
/// Use Policy](https://aws.amazon.com/aup/) and all
/// other Amazon terms. Remember that you must only use Amazon Kendra Web
/// Crawler
/// to index your own web pages, or web pages that you have authorization to
/// index.*
pub const Urls = struct {
    /// Configuration of the seed or starting point URLs of the websites you want to
    /// crawl.
    ///
    /// You can choose to crawl only the website host names, or the website host
    /// names with
    /// subdomains, or the website host names with subdomains and other domains that
    /// the
    /// web pages link to.
    ///
    /// You can list up to 100 seed URLs.
    seed_url_configuration: ?SeedUrlConfiguration,

    /// Configuration of the sitemap URLs of the websites you want to crawl.
    ///
    /// Only URLs belonging to the same website host names are crawled. You can list
    /// up to
    /// three sitemap URLs.
    site_maps_configuration: ?SiteMapsConfiguration,

    pub const json_field_names = .{
        .seed_url_configuration = "SeedUrlConfiguration",
        .site_maps_configuration = "SiteMapsConfiguration",
    };
};
