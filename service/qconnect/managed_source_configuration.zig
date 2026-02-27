const WebCrawlerConfiguration = @import("web_crawler_configuration.zig").WebCrawlerConfiguration;

/// Source configuration for managed resources.
pub const ManagedSourceConfiguration = union(enum) {
    /// Configuration data for web crawler data source.
    web_crawler_configuration: ?WebCrawlerConfiguration,

    pub const json_field_names = .{
        .web_crawler_configuration = "webCrawlerConfiguration",
    };
};
