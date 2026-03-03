const WebCrawlerConfiguration = @import("web_crawler_configuration.zig").WebCrawlerConfiguration;
const WebSourceConfiguration = @import("web_source_configuration.zig").WebSourceConfiguration;

/// The configuration details for the web data source.
pub const WebDataSourceConfiguration = struct {
    /// The Web Crawler configuration details for the web data source.
    crawler_configuration: ?WebCrawlerConfiguration = null,

    /// The source configuration details for the web data source.
    source_configuration: WebSourceConfiguration,

    pub const json_field_names = .{
        .crawler_configuration = "crawlerConfiguration",
        .source_configuration = "sourceConfiguration",
    };
};
