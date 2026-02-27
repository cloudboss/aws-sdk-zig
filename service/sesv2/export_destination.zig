const DataFormat = @import("data_format.zig").DataFormat;

/// An object that contains details about the destination of the export job.
pub const ExportDestination = struct {
    /// The data format of the final export job file, can be one of the following:
    ///
    /// * `CSV` - A comma-separated values file.
    ///
    /// * `JSON` - A Json file.
    data_format: DataFormat,

    /// An Amazon S3 pre-signed URL that points to the generated export file.
    s3_url: ?[]const u8,

    pub const json_field_names = .{
        .data_format = "DataFormat",
        .s3_url = "S3Url",
    };
};
