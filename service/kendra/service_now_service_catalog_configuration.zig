const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;

/// Provides the configuration information for crawling service catalog items in
/// the
/// ServiceNow site
pub const ServiceNowServiceCatalogConfiguration = struct {
    /// `TRUE` to index attachments to service catalog items.
    crawl_attachments: bool = false,

    /// The name of the ServiceNow field that is mapped to the index document
    /// contents field
    /// in the Amazon Kendra index.
    document_data_field_name: []const u8,

    /// The name of the ServiceNow field that is mapped to the index document title
    /// field.
    document_title_field_name: ?[]const u8,

    /// A list of regular expression patterns to exclude certain attachments of
    /// catalogs in
    /// your ServiceNow. Item that match the patterns are excluded from the index.
    /// Items that
    /// don't match the patterns are included in the index. If an item matches both
    /// an inclusion
    /// and exclusion pattern, the exclusion pattern takes precedence and the item
    /// isn't
    /// included in the index.
    ///
    /// The regex is applied to the file name of the attachment.
    exclude_attachment_file_patterns: ?[]const []const u8,

    /// Maps attributes or field names of catalogs to Amazon Kendra index field
    /// names. To
    /// create custom fields, use the `UpdateIndex` API before you map to ServiceNow
    /// fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// ServiceNow data source field names must exist in your ServiceNow custom
    /// metadata.
    field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of regular expression patterns to include certain attachments of
    /// catalogs in
    /// your ServiceNow. Item that match the patterns are included in the index.
    /// Items that
    /// don't match the patterns are excluded from the index. If an item matches
    /// both an
    /// inclusion and exclusion pattern, the exclusion pattern takes precedence and
    /// the item
    /// isn't included in the index.
    ///
    /// The regex is applied to the file name of the attachment.
    include_attachment_file_patterns: ?[]const []const u8,

    pub const json_field_names = .{
        .crawl_attachments = "CrawlAttachments",
        .document_data_field_name = "DocumentDataFieldName",
        .document_title_field_name = "DocumentTitleFieldName",
        .exclude_attachment_file_patterns = "ExcludeAttachmentFilePatterns",
        .field_mappings = "FieldMappings",
        .include_attachment_file_patterns = "IncludeAttachmentFilePatterns",
    };
};
