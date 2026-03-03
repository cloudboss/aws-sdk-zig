const ConfluenceDataSourceConfiguration = @import("confluence_data_source_configuration.zig").ConfluenceDataSourceConfiguration;
const S3DataSourceConfiguration = @import("s3_data_source_configuration.zig").S3DataSourceConfiguration;
const SalesforceDataSourceConfiguration = @import("salesforce_data_source_configuration.zig").SalesforceDataSourceConfiguration;
const SharePointDataSourceConfiguration = @import("share_point_data_source_configuration.zig").SharePointDataSourceConfiguration;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const WebDataSourceConfiguration = @import("web_data_source_configuration.zig").WebDataSourceConfiguration;

/// The connection configuration for the data source.
pub const DataSourceConfiguration = struct {
    /// The configuration information to connect to Confluence as your data source.
    ///
    /// Confluence data source connector is in preview release and is subject to
    /// change.
    confluence_configuration: ?ConfluenceDataSourceConfiguration = null,

    /// The configuration information to connect to Amazon S3 as your data source.
    s_3_configuration: ?S3DataSourceConfiguration = null,

    /// The configuration information to connect to Salesforce as your data source.
    ///
    /// Salesforce data source connector is in preview release and is subject to
    /// change.
    salesforce_configuration: ?SalesforceDataSourceConfiguration = null,

    /// The configuration information to connect to SharePoint as your data source.
    ///
    /// SharePoint data source connector is in preview release and is subject to
    /// change.
    share_point_configuration: ?SharePointDataSourceConfiguration = null,

    /// The type of data source.
    @"type": DataSourceType,

    /// The configuration of web URLs to crawl for your data source. You should be
    /// authorized to crawl the URLs.
    ///
    /// Crawling web URLs as your data source is in preview release and is subject
    /// to change.
    web_configuration: ?WebDataSourceConfiguration = null,

    pub const json_field_names = .{
        .confluence_configuration = "confluenceConfiguration",
        .s_3_configuration = "s3Configuration",
        .salesforce_configuration = "salesforceConfiguration",
        .share_point_configuration = "sharePointConfiguration",
        .@"type" = "type",
        .web_configuration = "webConfiguration",
    };
};
