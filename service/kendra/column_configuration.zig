const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;

/// Provides information about how Amazon Kendra should use the columns of a
/// database
/// in an index.
pub const ColumnConfiguration = struct {
    /// One to five columns that indicate when a document in the database has
    /// changed.
    change_detecting_columns: []const []const u8,

    /// The column that contains the contents of the document.
    document_data_column_name: []const u8,

    /// The column that provides the document's identifier.
    document_id_column_name: []const u8,

    /// The column that contains the title of the document.
    document_title_column_name: ?[]const u8,

    /// An array of objects that map database column names to the corresponding
    /// fields in an
    /// index. You must first create the fields in the index using the `UpdateIndex`
    /// API.
    field_mappings: ?[]const DataSourceToIndexFieldMapping,

    pub const json_field_names = .{
        .change_detecting_columns = "ChangeDetectingColumns",
        .document_data_column_name = "DocumentDataColumnName",
        .document_id_column_name = "DocumentIdColumnName",
        .document_title_column_name = "DocumentTitleColumnName",
        .field_mappings = "FieldMappings",
    };
};
