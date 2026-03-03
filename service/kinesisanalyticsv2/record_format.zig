const MappingParameters = @import("mapping_parameters.zig").MappingParameters;
const RecordFormatType = @import("record_format_type.zig").RecordFormatType;

/// For a SQL-based Kinesis Data Analytics application, describes the record
/// format
/// and relevant mapping information that should be applied to schematize the
/// records on the
/// stream.
pub const RecordFormat = struct {
    /// When you configure application input at the time of creating or updating an
    /// application,
    /// provides additional mapping information specific to the record format (such
    /// as JSON, CSV, or
    /// record fields delimited by some delimiter) on the streaming source.
    mapping_parameters: ?MappingParameters = null,

    /// The type of record format.
    record_format_type: RecordFormatType,

    pub const json_field_names = .{
        .mapping_parameters = "MappingParameters",
        .record_format_type = "RecordFormatType",
    };
};
