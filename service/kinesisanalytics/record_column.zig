/// Describes the mapping of each data element in the streaming
/// source to the corresponding column in the in-application stream.
///
/// Also used to describe the format of the reference data source.
pub const RecordColumn = struct {
    /// Reference to the data element in the streaming input or the reference data
    /// source. This element
    /// is required if the
    /// [RecordFormatType](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_RecordFormat.html#analytics-Type-RecordFormat-RecordFormatTypel) is `JSON`.
    mapping: ?[]const u8,

    /// Name of the column created in the in-application input stream or reference
    /// table.
    name: []const u8,

    /// Type of column created in the in-application input stream or reference
    /// table.
    sql_type: []const u8,

    pub const json_field_names = .{
        .mapping = "Mapping",
        .name = "Name",
        .sql_type = "SqlType",
    };
};
