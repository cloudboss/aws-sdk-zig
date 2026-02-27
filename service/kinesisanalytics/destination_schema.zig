const RecordFormatType = @import("record_format_type.zig").RecordFormatType;

/// Describes the data format when records are written to the destination.
/// For more information,
/// see [Configuring Application
/// Output](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-output.html).
pub const DestinationSchema = struct {
    /// Specifies the format of the records on the output stream.
    record_format_type: RecordFormatType,

    pub const json_field_names = .{
        .record_format_type = "RecordFormatType",
    };
};
