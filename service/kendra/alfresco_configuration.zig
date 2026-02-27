const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const AlfrescoEntity = @import("alfresco_entity.zig").AlfrescoEntity;
const S3Path = @import("s3_path.zig").S3Path;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to connect to Alfresco as your data
/// source.
///
/// Support for `AlfrescoConfiguration` ended May 2023.
/// We recommend migrating to or using the Alfresco data source template
/// schema /
/// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html) API.
pub const AlfrescoConfiguration = struct {
    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Alfresco blogs to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to Alfresco fields. For
    /// more
    /// information, see [
    /// Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Alfresco data source field names must exist
    /// in your Alfresco custom metadata.
    blog_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// `TRUE` to index comments of blogs and other content.
    crawl_comments: bool = false,

    /// `TRUE` to index shared files.
    crawl_system_folders: bool = false,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Alfresco document libraries to Amazon Kendra index field
    /// names. To create
    /// custom fields, use the `UpdateIndex` API before you map to Alfresco fields.
    /// For more information, see [ Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Alfresco data source field names must exist in your Alfresco custom
    /// metadata.
    document_library_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// Specify whether to index document libraries, wikis, or blogs. You can
    /// specify one or
    /// more of these options.
    entity_filter: ?[]const AlfrescoEntity,

    /// A list of regular expression patterns to exclude certain files in your
    /// Alfresco data
    /// source. Files that match the patterns are excluded from the index. Files
    /// that don't
    /// match the patterns are included in the index. If a file matches both an
    /// inclusion
    /// pattern and an exclusion pattern, the exclusion pattern takes precedence and
    /// the file
    /// isn't included in the index.
    exclusion_patterns: ?[]const []const u8,

    /// A list of regular expression patterns to include certain files in your
    /// Alfresco data
    /// source. Files that match the patterns are included in the index. Files that
    /// don't match
    /// the patterns are excluded from the index. If a file matches both an
    /// inclusion pattern
    /// and an exclusion pattern, the exclusion pattern takes precedence and the
    /// file isn't
    /// included in the index.
    inclusion_patterns: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of an Secrets Manager secret that contains
    /// the
    /// key-value pairs required to connect to your Alfresco data source. The secret
    /// must
    /// contain a JSON structure with the following keys:
    ///
    /// * username—The user name of the Alfresco account.
    ///
    /// * password—The password of the Alfresco account.
    secret_arn: []const u8,

    /// The identifier of the Alfresco site. For example, *my-site*.
    site_id: []const u8,

    /// The URL of the Alfresco site. For example,
    /// *https://hostname:8080*.
    site_url: []const u8,

    /// The path to the SSL certificate stored in an Amazon S3 bucket. You use this
    /// to
    /// connect to Alfresco if you require a secure SSL connection.
    ///
    /// You can simply generate a self-signed X509 certificate on any computer using
    /// OpenSSL.
    /// For an example of using OpenSSL to create an X509 certificate, see [Create
    /// and sign an X509
    /// certificate](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/configuring-https-ssl.html).
    ssl_certificate_s3_path: S3Path,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your Alfresco.
    /// For more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Alfresco wikis to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to Alfresco fields. For
    /// more
    /// information, see [
    /// Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Alfresco data source field names must exist
    /// in your Alfresco custom metadata.
    wiki_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    pub const json_field_names = .{
        .blog_field_mappings = "BlogFieldMappings",
        .crawl_comments = "CrawlComments",
        .crawl_system_folders = "CrawlSystemFolders",
        .document_library_field_mappings = "DocumentLibraryFieldMappings",
        .entity_filter = "EntityFilter",
        .exclusion_patterns = "ExclusionPatterns",
        .inclusion_patterns = "InclusionPatterns",
        .secret_arn = "SecretArn",
        .site_id = "SiteId",
        .site_url = "SiteUrl",
        .ssl_certificate_s3_path = "SslCertificateS3Path",
        .vpc_configuration = "VpcConfiguration",
        .wiki_field_mappings = "WikiFieldMappings",
    };
};
