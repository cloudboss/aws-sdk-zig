const RecordColumn = @import("record_column.zig").RecordColumn;
const RecordFormat = @import("record_format.zig").RecordFormat;

/// Describes updates for an SQL-based Kinesis Data Analytics application's
/// input
/// schema.
pub const InputSchemaUpdate = struct {
    /// A list of `RecordColumn` objects. Each object describes the mapping
    /// of the streaming source element to the corresponding column in the
    /// in-application stream.
    record_column_updates: ?[]const RecordColumn,

    /// Specifies the encoding of the records in the streaming source; for example,
    /// UTF-8.
    record_encoding_update: ?[]const u8,

    /// Specifies the format of the records on the streaming source.
    record_format_update: ?RecordFormat,

    pub const json_field_names = .{
        .record_column_updates = "RecordColumnUpdates",
        .record_encoding_update = "RecordEncodingUpdate",
        .record_format_update = "RecordFormatUpdate",
    };
};
