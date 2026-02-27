const CrawlFilterConfiguration = @import("crawl_filter_configuration.zig").CrawlFilterConfiguration;

/// The configuration of the Salesforce content. For example, configuring
/// specific types of Salesforce content.
pub const SalesforceCrawlerConfiguration = struct {
    /// The configuration of filtering the Salesforce content. For example,
    /// configuring regular expression patterns to include or exclude certain
    /// content.
    filter_configuration: ?CrawlFilterConfiguration,

    pub const json_field_names = .{
        .filter_configuration = "filterConfiguration",
    };
};
