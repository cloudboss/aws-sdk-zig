const RecordColumn = @import("record_column.zig").RecordColumn;
const RecordFormat = @import("record_format.zig").RecordFormat;

/// For a SQL-based Kinesis Data Analytics application, describes the format of
/// the
/// data in the streaming source, and how each data element maps to
/// corresponding columns created
/// in the in-application stream.
pub const SourceSchema = struct {
    /// A list of `RecordColumn` objects.
    record_columns: []const RecordColumn,

    /// Specifies the encoding of the records in the streaming source. For example,
    /// UTF-8.
    record_encoding: ?[]const u8 = null,

    /// Specifies the format of the records on the streaming source.
    record_format: RecordFormat,

    pub const json_field_names = .{
        .record_columns = "RecordColumns",
        .record_encoding = "RecordEncoding",
        .record_format = "RecordFormat",
    };
};
