const SalesforceCrawlerConfiguration = @import("salesforce_crawler_configuration.zig").SalesforceCrawlerConfiguration;
const SalesforceSourceConfiguration = @import("salesforce_source_configuration.zig").SalesforceSourceConfiguration;

/// The configuration information to connect to Salesforce as your data source.
pub const SalesforceDataSourceConfiguration = struct {
    /// The configuration of the Salesforce content. For example, configuring
    /// specific types of Salesforce content.
    crawler_configuration: ?SalesforceCrawlerConfiguration,

    /// The endpoint information to connect to your Salesforce data source.
    source_configuration: SalesforceSourceConfiguration,

    pub const json_field_names = .{
        .crawler_configuration = "crawlerConfiguration",
        .source_configuration = "sourceConfiguration",
    };
};
