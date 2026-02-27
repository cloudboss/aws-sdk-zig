const RecordFormatType = @import("record_format_type.zig").RecordFormatType;

/// Describes the data format when records are written to the destination in a
/// SQL-based Kinesis Data Analytics application.
pub const DestinationSchema = struct {
    /// Specifies the format of the records on the output stream.
    record_format_type: RecordFormatType,

    pub const json_field_names = .{
        .record_format_type = "RecordFormatType",
    };
};
