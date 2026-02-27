const SharePointOnlineAuthenticationType = @import("share_point_online_authentication_type.zig").SharePointOnlineAuthenticationType;
const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const ProxyConfiguration = @import("proxy_configuration.zig").ProxyConfiguration;
const SharePointVersion = @import("share_point_version.zig").SharePointVersion;
const S3Path = @import("s3_path.zig").S3Path;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to connect to Microsoft SharePoint as
/// your data
/// source.
pub const SharePointConfiguration = struct {
    /// Whether you want to connect to SharePoint Online using basic authentication
    /// of user
    /// name and password, or OAuth authentication of user name, password, client
    /// ID, and client
    /// secret, or AD App-only authentication of client secret.
    authentication_type: ?SharePointOnlineAuthenticationType,

    /// `TRUE` to index document attachments.
    crawl_attachments: bool = false,

    /// `TRUE` to disable local groups information.
    disable_local_groups: bool = false,

    /// The Microsoft SharePoint attribute field that contains the title of the
    /// document.
    document_title_field_name: ?[]const u8,

    /// A list of regular expression patterns to exclude certain documents in your
    /// SharePoint.
    /// Documents that match the patterns are excluded from the index. Documents
    /// that don't
    /// match the patterns are included in the index. If a document matches both an
    /// inclusion
    /// and exclusion pattern, the exclusion pattern takes precedence and the
    /// document isn't
    /// included in the index.
    ///
    /// The regex applies to the display URL of the SharePoint document.
    exclusion_patterns: ?[]const []const u8,

    /// A list of `DataSourceToIndexFieldMapping` objects that map SharePoint data
    /// source attributes or field names to Amazon Kendra index field names. To
    /// create
    /// custom fields, use the `UpdateIndex` API before you map to SharePoint
    /// fields.
    /// For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// SharePoint data source field names must exist in your SharePoint custom
    /// metadata.
    field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of regular expression patterns to include certain documents in your
    /// SharePoint.
    /// Documents that match the patterns are included in the index. Documents that
    /// don't match
    /// the patterns are excluded from the index. If a document matches both an
    /// inclusion and
    /// exclusion pattern, the exclusion pattern takes precedence and the document
    /// isn't
    /// included in the index.
    ///
    /// The regex applies to the display URL of the SharePoint document.
    inclusion_patterns: ?[]const []const u8,

    /// Configuration information to connect to your Microsoft SharePoint site URLs
    /// via
    /// instance via a web proxy. You can use this option for SharePoint Server.
    ///
    /// You must provide the website host name and port number. For example, the
    /// host name of
    /// *https://a.example.com/page1.html* is "a.example.com" and the
    /// port is 443, the standard port for HTTPS.
    ///
    /// Web proxy credentials are optional and you can use them to connect to a web
    /// proxy
    /// server that requires basic authentication of user name and password. To
    /// store web proxy
    /// credentials, you use a secret in Secrets Manager.
    ///
    /// It is recommended that you follow best security practices when configuring
    /// your web
    /// proxy. This includes setting up throttling, setting up logging and
    /// monitoring, and
    /// applying security patches on a regular basis. If you use your web proxy with
    /// multiple
    /// data sources, sync jobs that occur at the same time could strain the load on
    /// your proxy.
    /// It is recommended you prepare your proxy beforehand for any security and
    /// load
    /// requirements.
    proxy_configuration: ?ProxyConfiguration,

    /// The Amazon Resource Name (ARN) of an Secrets Manager secret that contains
    /// the
    /// user name and password required to connect to the SharePoint instance. For
    /// more
    /// information, see [Microsoft
    /// SharePoint](https://docs.aws.amazon.com/kendra/latest/dg/data-source-sharepoint.html).
    secret_arn: []const u8,

    /// The version of Microsoft SharePoint that you use.
    share_point_version: SharePointVersion,

    /// The path to the SSL certificate stored in an Amazon S3 bucket. You use this
    /// to
    /// connect to SharePoint Server if you require a secure SSL connection.
    ///
    /// You can generate a self-signed X509 certificate on any computer using
    /// OpenSSL. For an
    /// example of using OpenSSL to create an X509 certificate, see [Create and sign
    /// an X509
    /// certificate](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/configuring-https-ssl.html).
    ssl_certificate_s3_path: ?S3Path,

    /// The Microsoft SharePoint site URLs for the documents you want to index.
    urls: []const []const u8,

    /// `TRUE` to use the SharePoint change log to determine which documents
    /// require updating in the index. Depending on the change log's size, it may
    /// take longer
    /// for Amazon Kendra to use the change log than to scan all of your documents
    /// in
    /// SharePoint.
    use_change_log: bool = false,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your Microsoft
    /// SharePoint. For more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .crawl_attachments = "CrawlAttachments",
        .disable_local_groups = "DisableLocalGroups",
        .document_title_field_name = "DocumentTitleFieldName",
        .exclusion_patterns = "ExclusionPatterns",
        .field_mappings = "FieldMappings",
        .inclusion_patterns = "InclusionPatterns",
        .proxy_configuration = "ProxyConfiguration",
        .secret_arn = "SecretArn",
        .share_point_version = "SharePointVersion",
        .ssl_certificate_s3_path = "SslCertificateS3Path",
        .urls = "Urls",
        .use_change_log = "UseChangeLog",
        .vpc_configuration = "VpcConfiguration",
    };
};
