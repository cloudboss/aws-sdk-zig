const SharePointCrawlerConfiguration = @import("share_point_crawler_configuration.zig").SharePointCrawlerConfiguration;
const SharePointSourceConfiguration = @import("share_point_source_configuration.zig").SharePointSourceConfiguration;

/// The configuration information to connect to SharePoint as your data source.
pub const SharePointDataSourceConfiguration = struct {
    /// The configuration of the SharePoint content. For example, configuring
    /// specific types of SharePoint content.
    crawler_configuration: ?SharePointCrawlerConfiguration = null,

    /// The endpoint information to connect to your SharePoint data source.
    source_configuration: SharePointSourceConfiguration,

    pub const json_field_names = .{
        .crawler_configuration = "crawlerConfiguration",
        .source_configuration = "sourceConfiguration",
    };
};
