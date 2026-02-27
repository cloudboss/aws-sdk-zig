const aws = @import("aws");

const ExportFileFormat = @import("export_file_format.zig").ExportFileFormat;

/// Structure for the Dataview destination type parameters.
pub const DataViewDestinationTypeParams = struct {
    /// Destination type for a Dataview.
    ///
    /// * `GLUE_TABLE` – Glue table destination type.
    ///
    /// * `S3` – S3 destination type.
    destination_type: []const u8,

    /// Dataview export file format.
    ///
    /// * `PARQUET` – Parquet export file format.
    ///
    /// * `DELIMITED_TEXT` – Delimited text export file format.
    s_3_destination_export_file_format: ?ExportFileFormat,

    /// Format Options for S3 Destination type.
    ///
    /// Here is an example of how you could specify the
    /// `s3DestinationExportFileFormatOptions`
    ///
    /// `
    /// {
    /// "header": "true",
    /// "delimiter": ",",
    /// "compression": "gzip"
    /// }`
    s_3_destination_export_file_format_options: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .destination_type = "destinationType",
        .s_3_destination_export_file_format = "s3DestinationExportFileFormat",
        .s_3_destination_export_file_format_options = "s3DestinationExportFileFormatOptions",
    };
};
