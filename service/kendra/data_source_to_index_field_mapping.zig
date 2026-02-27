/// Maps attributes or field names of the documents synced from the data source
/// to Amazon Kendra index field names. You can set up field mappings for each
/// data source when calling
/// [CreateDataSource](https://docs.aws.amazon.com/kendra/latest/APIReference/API_CreateDataSource.html)
/// or
/// [UpdateDataSource](https://docs.aws.amazon.com/kendra/latest/APIReference/API_UpdateDataSource.html) API. To create custom fields, use the `UpdateIndex`
/// API to first create an index field and then map to the data source field.
/// For more
/// information, see [Mapping data source
/// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
pub const DataSourceToIndexFieldMapping = struct {
    /// The name of the field in the data source. You must first create the index
    /// field
    /// using the `UpdateIndex` API.
    data_source_field_name: []const u8,

    /// The format for date fields in the data source. If the field specified in
    /// `DataSourceFieldName` is a date field, you must specify the date
    /// format. If the field is not a date field, an exception is thrown.
    date_field_format: ?[]const u8,

    /// The name of the index field to map to the data source field. The index field
    /// type
    /// must match the data source field type.
    index_field_name: []const u8,

    pub const json_field_names = .{
        .data_source_field_name = "DataSourceFieldName",
        .date_field_format = "DateFieldFormat",
        .index_field_name = "IndexFieldName",
    };
};
