/// Provides the configuration information for the sitemap URLs to crawl.
///
/// *When selecting websites to index, you must adhere to the [Amazon Acceptable
/// Use Policy](https://aws.amazon.com/aup/) and all
/// other Amazon terms. Remember that you must only use Amazon Kendra Web
/// Crawler
/// to index your own web pages, or web pages that you have authorization to
/// index.*
pub const SiteMapsConfiguration = struct {
    /// The list of sitemap URLs of the websites you want to crawl.
    ///
    /// The list can include a maximum of three sitemap URLs.
    site_maps: []const []const u8,

    pub const json_field_names = .{
        .site_maps = "SiteMaps",
    };
};
