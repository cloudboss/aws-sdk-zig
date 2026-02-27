const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to connect to Box as
/// your data source.
pub const BoxConfiguration = struct {
    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes
    /// or field names of Box comments to Amazon Kendra index field names. To create
    /// custom fields, use the `UpdateIndex` API before you map to Box fields.
    /// For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Box field names must exist in your Box custom metadata.
    comment_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// `TRUE` to index comments.
    crawl_comments: bool = false,

    /// `TRUE` to index the contents of tasks.
    crawl_tasks: bool = false,

    /// `TRUE` to index web links.
    crawl_web_links: bool = false,

    /// The identifier of the Box Enterprise platform. You can find the enterprise
    /// ID in the Box Developer Console settings or when you create an app in Box
    /// and
    /// download your authentication credentials. For example, *801234567*.
    enterprise_id: []const u8,

    /// A list of regular expression patterns to exclude certain files and folders
    /// from
    /// your Box platform. Files and folders that match the patterns are excluded
    /// from the
    /// index.Files and folders that don't match the patterns are included in the
    /// index.
    /// If a file or folder matches both an inclusion and exclusion pattern, the
    /// exclusion
    /// pattern takes precedence and the file or folder isn't included in the index.
    exclusion_patterns: ?[]const []const u8,

    /// A
    /// list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Box files to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to Box fields. For more
    /// information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Box field names must exist in your Box custom metadata.
    file_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of regular expression patterns to include certain files and folders
    /// in your
    /// Box platform. Files and folders that match the patterns are included in the
    /// index.
    /// Files and folders that don't match the patterns are excluded from the index.
    /// If a
    /// file or folder matches both an inclusion and exclusion pattern, the
    /// exclusion pattern
    /// takes precedence and the file or folder isn't included in the index.
    inclusion_patterns: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of an Secrets Manager secret that contains
    /// the key-value pairs required to connect to your Box platform. The secret
    /// must
    /// contain a JSON structure with the following keys:
    ///
    /// * clientID—The identifier of the client OAuth 2.0 authentication
    /// application created in Box.
    ///
    /// * clientSecret—A set of characters known only to the OAuth 2.0
    /// authentication application created in Box.
    ///
    /// * publicKeyId—The identifier of the public key contained within an
    /// identity certificate.
    ///
    /// * privateKey—A set of characters that make up an encryption key.
    ///
    /// * passphrase—A set of characters that act like a password.
    ///
    /// You create an application in Box to generate the keys or credentials
    /// required
    /// for the secret. For more information, see [Using a Box data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-box.html).
    secret_arn: []const u8,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes
    /// or field names of Box tasks to Amazon Kendra index field names. To create
    /// custom fields, use the `UpdateIndex` API before you map to Box fields.
    /// For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Box field names must exist in your Box custom metadata.
    task_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// `TRUE` to use the Slack change log to determine which documents require
    /// updating in the index. Depending on the data source change log's size, it
    /// may take
    /// longer for Amazon Kendra to use the change log than to scan all of your
    /// documents.
    use_change_log: bool = false,

    /// Configuration information for an Amazon VPC to connect to your Box. For
    /// more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes
    /// or field names of Box web links to Amazon Kendra index field names. To
    /// create
    /// custom fields, use the `UpdateIndex` API before you map to Box fields.
    /// For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Box field names must exist in your Box custom metadata.
    web_link_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    pub const json_field_names = .{
        .comment_field_mappings = "CommentFieldMappings",
        .crawl_comments = "CrawlComments",
        .crawl_tasks = "CrawlTasks",
        .crawl_web_links = "CrawlWebLinks",
        .enterprise_id = "EnterpriseId",
        .exclusion_patterns = "ExclusionPatterns",
        .file_field_mappings = "FileFieldMappings",
        .inclusion_patterns = "InclusionPatterns",
        .secret_arn = "SecretArn",
        .task_field_mappings = "TaskFieldMappings",
        .use_change_log = "UseChangeLog",
        .vpc_configuration = "VpcConfiguration",
        .web_link_field_mappings = "WebLinkFieldMappings",
    };
};
