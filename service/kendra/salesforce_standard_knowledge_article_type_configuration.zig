const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;

/// Provides the configuration information for standard Salesforce knowledge
/// articles.
pub const SalesforceStandardKnowledgeArticleTypeConfiguration = struct {
    /// The name of the field that contains the document data to index.
    document_data_field_name: []const u8,

    /// The name of the field that contains the document title.
    document_title_field_name: ?[]const u8,

    /// Maps attributes or field names of the knowledge article to Amazon Kendra
    /// index
    /// field names. To create custom fields, use the `UpdateIndex` API before you
    /// map to Salesforce fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Salesforce data source field names must exist in your Salesforce custom
    /// metadata.
    field_mappings: ?[]const DataSourceToIndexFieldMapping,

    pub const json_field_names = .{
        .document_data_field_name = "DocumentDataFieldName",
        .document_title_field_name = "DocumentTitleFieldName",
        .field_mappings = "FieldMappings",
    };
};
