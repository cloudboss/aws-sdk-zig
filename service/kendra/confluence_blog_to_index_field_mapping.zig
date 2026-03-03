const ConfluenceBlogFieldName = @import("confluence_blog_field_name.zig").ConfluenceBlogFieldName;

/// Maps attributes or field names of Confluence blog to Amazon Kendra index
/// field
/// names. To create custom fields, use the `UpdateIndex` API before you map to
/// Confluence fields. For more information, see [Mapping data source
/// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
/// The
/// Confluence data source field names must exist in your Confluence custom
/// metadata.
pub const ConfluenceBlogToIndexFieldMapping = struct {
    /// The name of the field in the data source.
    data_source_field_name: ?ConfluenceBlogFieldName = null,

    /// The format for date fields in the data source. If the field specified in
    /// `DataSourceFieldName` is a date field you must specify the date format.
    /// If the field is not a date field, an exception is thrown.
    date_field_format: ?[]const u8 = null,

    /// The name of the index field to map to the Confluence data source field. The
    /// index
    /// field type must match the Confluence field type.
    index_field_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_field_name = "DataSourceFieldName",
        .date_field_format = "DateFieldFormat",
        .index_field_name = "IndexFieldName",
    };
};
