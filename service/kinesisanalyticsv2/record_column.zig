/// For a SQL-based Kinesis Data Analytics application, describes the mapping of
/// each
/// data element in the streaming source to the corresponding column in the
/// in-application
/// stream.
///
/// Also used to describe the format of the reference data source.
pub const RecordColumn = struct {
    /// A reference to the data element in the streaming input or the reference data
    /// source.
    mapping: ?[]const u8 = null,

    /// The name of the column that is created in the in-application input stream or
    /// reference
    /// table.
    name: []const u8,

    /// The type of column created in the in-application input stream or reference
    /// table.
    sql_type: []const u8,

    pub const json_field_names = .{
        .mapping = "Mapping",
        .name = "Name",
        .sql_type = "SqlType",
    };
};
