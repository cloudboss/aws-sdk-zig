const CrawlFilterConfiguration = @import("crawl_filter_configuration.zig").CrawlFilterConfiguration;

/// The configuration of the SharePoint content. For example, configuring
/// specific types of SharePoint content.
pub const SharePointCrawlerConfiguration = struct {
    /// The configuration of filtering the SharePoint content. For example,
    /// configuring regular expression patterns to include or exclude certain
    /// content.
    filter_configuration: ?CrawlFilterConfiguration = null,

    pub const json_field_names = .{
        .filter_configuration = "filterConfiguration",
    };
};
