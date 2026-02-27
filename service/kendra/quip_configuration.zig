const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to connect to Quip as your data
/// source.
pub const QuipConfiguration = struct {
    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Quip attachments to Amazon Kendra index field names. To
    /// create
    /// custom fields, use the `UpdateIndex` API before you map to Quip fields. For
    /// more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Quip field names must exist in your Quip custom metadata.
    attachment_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// `TRUE` to index attachments.
    crawl_attachments: bool = false,

    /// `TRUE` to index the contents of chat rooms.
    crawl_chat_rooms: bool = false,

    /// `TRUE` to index file comments.
    crawl_file_comments: bool = false,

    /// The Quip site domain. For example,
    /// *https://quip-company.quipdomain.com/browse*. The domain in this
    /// example is "quipdomain".
    domain: []const u8,

    /// A list of regular expression patterns to exclude certain files in your Quip
    /// file
    /// system. Files that match the patterns are excluded from the index. Files
    /// that don’t
    /// match the patterns are included in the index. If a file matches both an
    /// inclusion
    /// pattern and an exclusion pattern, the exclusion pattern takes precedence,
    /// and the file
    /// isn't included in the index.
    exclusion_patterns: ?[]const []const u8,

    /// The identifiers of the Quip folders you want to index. You can find the
    /// folder ID in
    /// your browser URL when you access your folder in Quip. For example,
    /// *https://quip-company.quipdomain.com/zlLuOVNSarTL/folder-name*.
    /// The folder ID in this example is "zlLuOVNSarTL".
    folder_ids: ?[]const []const u8,

    /// A list of regular expression patterns to include certain files in your Quip
    /// file
    /// system. Files that match the patterns are included in the index. Files that
    /// don't match
    /// the patterns are excluded from the index. If a file matches both an
    /// inclusion pattern
    /// and an exclusion pattern, the exclusion pattern takes precedence, and the
    /// file isn't
    /// included in the index.
    inclusion_patterns: ?[]const []const u8,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Quip messages to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to Quip fields. For more
    /// information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Quip field names must exist in your Quip
    /// custom metadata.
    message_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// The Amazon Resource Name (ARN) of an Secrets Manager secret that contains
    /// the
    /// key-value pairs that are required to connect to your Quip. The secret must
    /// contain a
    /// JSON structure with the following keys:
    ///
    /// * accessToken—The token created in Quip. For more information, see [Using a
    /// Quip data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-slack.html).
    secret_arn: []const u8,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Quip threads to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to Quip fields. For more
    /// information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Quip field names must exist in your Quip
    /// custom metadata.
    thread_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// Configuration information for an Amazon Virtual Private Cloud (VPC) to
    /// connect to your Quip.
    /// For more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration,

    pub const json_field_names = .{
        .attachment_field_mappings = "AttachmentFieldMappings",
        .crawl_attachments = "CrawlAttachments",
        .crawl_chat_rooms = "CrawlChatRooms",
        .crawl_file_comments = "CrawlFileComments",
        .domain = "Domain",
        .exclusion_patterns = "ExclusionPatterns",
        .folder_ids = "FolderIds",
        .inclusion_patterns = "InclusionPatterns",
        .message_field_mappings = "MessageFieldMappings",
        .secret_arn = "SecretArn",
        .thread_field_mappings = "ThreadFieldMappings",
        .vpc_configuration = "VpcConfiguration",
    };
};
