const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;

/// Provides the configuration information to connect to Amazon WorkDocs
/// as your data source.
///
/// Amazon WorkDocs connector is available in Oregon, North Virginia, Sydney,
/// Singapore and Ireland
/// regions.
pub const WorkDocsConfiguration = struct {
    /// `TRUE` to include comments on documents
    /// in your index. Including comments in your index means each comment
    /// is a document that can be searched on.
    ///
    /// The default is set to `FALSE`.
    crawl_comments: bool = false,

    /// A list of regular expression patterns to exclude certain files
    /// in your Amazon WorkDocs site repository. Files that match the patterns
    /// are excluded from the index. Files that don’t match the patterns
    /// are included in the index. If a file matches both an inclusion and exclusion
    /// pattern, the exclusion pattern takes precedence and the file isn't included
    /// in the index.
    exclusion_patterns: ?[]const []const u8 = null,

    /// A list of `DataSourceToIndexFieldMapping` objects that
    /// map Amazon WorkDocs data source attributes or field names to Amazon Kendra
    /// index field names. To create custom fields, use the
    /// `UpdateIndex` API before you map to Amazon WorkDocs fields.
    /// For more information, see [Mapping
    /// data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Amazon WorkDocs data source field names
    /// must exist in your Amazon WorkDocs custom metadata.
    field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    /// A list of regular expression patterns to include certain files
    /// in your Amazon WorkDocs site repository. Files that match the patterns
    /// are included in the index. Files that don't match the patterns are
    /// excluded from the index. If a file matches both an inclusion and exclusion
    /// pattern, the exclusion pattern takes precedence and the file isn't included
    /// in the index.
    inclusion_patterns: ?[]const []const u8 = null,

    /// The identifier of the directory corresponding to your
    /// Amazon WorkDocs site repository.
    ///
    /// You can find the organization ID in the
    /// [Directory Service](https://console.aws.amazon.com/directoryservicev2/) by
    /// going to
    /// **Active Directory**, then
    /// **Directories**. Your Amazon WorkDocs site directory has an
    /// ID, which is the organization ID. You can also set up a new Amazon WorkDocs
    /// directory in the Directory Service console and enable a Amazon WorkDocs site
    /// for the directory in the Amazon WorkDocs console.
    organization_id: []const u8,

    /// `TRUE` to use the Amazon WorkDocs change log to determine
    /// which documents require updating in the index. Depending on the change log's
    /// size, it may take longer for Amazon Kendra to use the change log than to
    /// scan all of your documents in Amazon WorkDocs.
    use_change_log: bool = false,

    pub const json_field_names = .{
        .crawl_comments = "CrawlComments",
        .exclusion_patterns = "ExclusionPatterns",
        .field_mappings = "FieldMappings",
        .inclusion_patterns = "InclusionPatterns",
        .organization_id = "OrganizationId",
        .use_change_log = "UseChangeLog",
    };
};
