const UrlConfiguration = @import("url_configuration.zig").UrlConfiguration;

/// The configuration of the URL/URLs for the web content that you want to
/// crawl. You should be authorized to crawl the URLs.
pub const WebSourceConfiguration = struct {
    /// The configuration of the URL/URLs.
    url_configuration: UrlConfiguration,

    pub const json_field_names = .{
        .url_configuration = "urlConfiguration",
    };
};
