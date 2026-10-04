const RecordFormatType = @import("record_format_type.zig").RecordFormatType;

/// Specifies the format of records read from the source stream.
pub const RecordConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Glue Schema
    /// Registry schema used to validate records. Required when the channel
    /// destination is a streaming table.
    gsr_schema_arn: ?[]const u8 = null,

    /// The format of records on the source stream. Valid values:
    ///
    /// * `GSR_JSON` - Supported only for streaming table (Amazon S3 Tables)
    ///   destinations.
    ///
    /// * `JSON` - Supported for both general purpose Amazon S3 and streaming table
    ///   destinations.
    ///
    /// * `STRING` - Supported only for general purpose Amazon S3 destinations.
    ///
    /// * `BYTE_ARRAY` - Supported only for general purpose Amazon S3 destinations.
    record_format_type: RecordFormatType,

    pub const json_field_names = .{
        .gsr_schema_arn = "GSRSchemaARN",
        .record_format_type = "RecordFormatType",
    };
};
