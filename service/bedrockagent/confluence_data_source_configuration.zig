const ConfluenceCrawlerConfiguration = @import("confluence_crawler_configuration.zig").ConfluenceCrawlerConfiguration;
const ConfluenceSourceConfiguration = @import("confluence_source_configuration.zig").ConfluenceSourceConfiguration;

/// The configuration information to connect to Confluence as your data source.
pub const ConfluenceDataSourceConfiguration = struct {
    /// The configuration of the Confluence content. For example, configuring
    /// specific types of Confluence content.
    crawler_configuration: ?ConfluenceCrawlerConfiguration = null,

    /// The endpoint information to connect to your Confluence data source.
    source_configuration: ConfluenceSourceConfiguration,

    pub const json_field_names = .{
        .crawler_configuration = "crawlerConfiguration",
        .source_configuration = "sourceConfiguration",
    };
};
