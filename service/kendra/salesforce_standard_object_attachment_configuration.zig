const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;

/// Provides the configuration information for processing attachments to
/// Salesforce
/// standard objects.
pub const SalesforceStandardObjectAttachmentConfiguration = struct {
    /// The name of the field used for the document title.
    document_title_field_name: ?[]const u8 = null,

    /// One or more objects that map fields in attachments to Amazon Kendra index
    /// fields.
    field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    pub const json_field_names = .{
        .document_title_field_name = "DocumentTitleFieldName",
        .field_mappings = "FieldMappings",
    };
};
