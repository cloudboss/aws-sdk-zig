const AlfrescoConfiguration = @import("alfresco_configuration.zig").AlfrescoConfiguration;
const BoxConfiguration = @import("box_configuration.zig").BoxConfiguration;
const ConfluenceConfiguration = @import("confluence_configuration.zig").ConfluenceConfiguration;
const DatabaseConfiguration = @import("database_configuration.zig").DatabaseConfiguration;
const FsxConfiguration = @import("fsx_configuration.zig").FsxConfiguration;
const GitHubConfiguration = @import("git_hub_configuration.zig").GitHubConfiguration;
const GoogleDriveConfiguration = @import("google_drive_configuration.zig").GoogleDriveConfiguration;
const JiraConfiguration = @import("jira_configuration.zig").JiraConfiguration;
const OneDriveConfiguration = @import("one_drive_configuration.zig").OneDriveConfiguration;
const QuipConfiguration = @import("quip_configuration.zig").QuipConfiguration;
const S3DataSourceConfiguration = @import("s3_data_source_configuration.zig").S3DataSourceConfiguration;
const SalesforceConfiguration = @import("salesforce_configuration.zig").SalesforceConfiguration;
const ServiceNowConfiguration = @import("service_now_configuration.zig").ServiceNowConfiguration;
const SharePointConfiguration = @import("share_point_configuration.zig").SharePointConfiguration;
const SlackConfiguration = @import("slack_configuration.zig").SlackConfiguration;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;
const WebCrawlerConfiguration = @import("web_crawler_configuration.zig").WebCrawlerConfiguration;
const WorkDocsConfiguration = @import("work_docs_configuration.zig").WorkDocsConfiguration;

/// Provides the configuration information for an Amazon Kendra data source.
pub const DataSourceConfiguration = struct {
    /// Provides the configuration information to connect to Alfresco as your data
    /// source.
    ///
    /// Support for `AlfrescoConfiguration` ended May 2023.
    /// We recommend migrating to or using the Alfresco data source template
    /// schema /
    /// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html)
    /// API.
    alfresco_configuration: ?AlfrescoConfiguration,

    /// Provides the configuration information to connect to Box as your data
    /// source.
    box_configuration: ?BoxConfiguration,

    /// Provides the configuration information to connect to Confluence as your data
    /// source.
    confluence_configuration: ?ConfluenceConfiguration,

    /// Provides the configuration information to connect to a database as your data
    /// source.
    database_configuration: ?DatabaseConfiguration,

    /// Provides the configuration information to connect to Amazon FSx as your data
    /// source.
    ///
    /// Amazon Kendra now supports an upgraded Amazon FSx Windows connector.
    ///
    /// You must now use the
    /// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html) object instead of the
    /// `FsxConfiguration` object to configure your connector.
    ///
    /// Connectors configured using the older console and API architecture will
    /// continue to
    /// function as configured. However, you won't be able to edit or update them.
    /// If you want
    /// to edit or update your connector configuration, you must create a new
    /// connector.
    ///
    /// We recommended migrating your connector workflow to the upgraded version.
    /// Support for
    /// connectors configured using the older architecture is scheduled to end by
    /// June 2024.
    fsx_configuration: ?FsxConfiguration,

    /// Provides the configuration information to connect to GitHub as your data
    /// source.
    ///
    /// Amazon Kendra now supports an upgraded GitHub connector.
    ///
    /// You must now use the
    /// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html) object instead of the
    /// `GitHubConfiguration` object to configure your connector.
    ///
    /// Connectors configured using the older console and API architecture will
    /// continue
    /// to function as configured. However, you won’t be able to edit or update
    /// them. If you
    /// want to edit or update your connector configuration, you must create a new
    /// connector.
    ///
    /// We recommended migrating your connector workflow to the upgraded version.
    /// Support
    /// for connectors configured using the older architecture is scheduled to end
    /// by June
    /// 2024.
    git_hub_configuration: ?GitHubConfiguration,

    /// Provides the configuration information to connect to Google Drive as your
    /// data
    /// source.
    google_drive_configuration: ?GoogleDriveConfiguration,

    /// Provides the configuration information to connect to Jira as your data
    /// source.
    jira_configuration: ?JiraConfiguration,

    /// Provides the configuration information to connect to Microsoft OneDrive as
    /// your data
    /// source.
    one_drive_configuration: ?OneDriveConfiguration,

    /// Provides the configuration information to connect to Quip as your data
    /// source.
    quip_configuration: ?QuipConfiguration,

    /// Provides the configuration information to connect to an Amazon S3 bucket as
    /// your
    /// data source.
    ///
    /// Amazon Kendra now supports an upgraded Amazon S3 connector.
    ///
    /// You must now use the
    /// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html) object instead of the
    /// `S3DataSourceConfiguration` object to configure your connector.
    ///
    /// Connectors configured using the older console and API architecture will
    /// continue to
    /// function as configured. However, you won't be able to edit or update them.
    /// If you want
    /// to edit or update your connector configuration, you must create a new
    /// connector.
    ///
    /// We recommended migrating your connector workflow to the upgraded version.
    /// Support for
    /// connectors configured using the older architecture is scheduled to end by
    /// June 2024.
    s3_configuration: ?S3DataSourceConfiguration,

    /// Provides the configuration information to connect to Salesforce as your data
    /// source.
    salesforce_configuration: ?SalesforceConfiguration,

    /// Provides the configuration information to connect to ServiceNow as your data
    /// source.
    service_now_configuration: ?ServiceNowConfiguration,

    /// Provides the configuration information to connect to Microsoft SharePoint as
    /// your data
    /// source.
    share_point_configuration: ?SharePointConfiguration,

    /// Provides the configuration information to connect to Slack as your data
    /// source.
    ///
    /// Amazon Kendra now supports an upgraded Slack connector.
    ///
    /// You must now use the
    /// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html) object instead of the
    /// `SlackConfiguration` object to configure your connector.
    ///
    /// Connectors configured using the older console and API architecture will
    /// continue to
    /// function as configured. However, you won't be able to edit or update them.
    /// If you want
    /// to edit or update your connector configuration, you must create a new
    /// connector.
    ///
    /// We recommended migrating your connector workflow to the upgraded version.
    /// Support for
    /// connectors configured using the older architecture is scheduled to end by
    /// June 2024.
    slack_configuration: ?SlackConfiguration,

    /// Provides a template for the configuration information to connect to your
    /// data
    /// source.
    template_configuration: ?TemplateConfiguration,

    web_crawler_configuration: ?WebCrawlerConfiguration,

    /// Provides the configuration information to connect to Amazon WorkDocs as your
    /// data
    /// source.
    work_docs_configuration: ?WorkDocsConfiguration,

    pub const json_field_names = .{
        .alfresco_configuration = "AlfrescoConfiguration",
        .box_configuration = "BoxConfiguration",
        .confluence_configuration = "ConfluenceConfiguration",
        .database_configuration = "DatabaseConfiguration",
        .fsx_configuration = "FsxConfiguration",
        .git_hub_configuration = "GitHubConfiguration",
        .google_drive_configuration = "GoogleDriveConfiguration",
        .jira_configuration = "JiraConfiguration",
        .one_drive_configuration = "OneDriveConfiguration",
        .quip_configuration = "QuipConfiguration",
        .s3_configuration = "S3Configuration",
        .salesforce_configuration = "SalesforceConfiguration",
        .service_now_configuration = "ServiceNowConfiguration",
        .share_point_configuration = "SharePointConfiguration",
        .slack_configuration = "SlackConfiguration",
        .template_configuration = "TemplateConfiguration",
        .web_crawler_configuration = "WebCrawlerConfiguration",
        .work_docs_configuration = "WorkDocsConfiguration",
    };
};
