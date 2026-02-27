const DataFormat = @import("data_format.zig").DataFormat;

/// An object that contains details about the data source of the import job.
pub const ImportDataSource = struct {
    /// The data format of the import job's data source.
    data_format: DataFormat,

    /// An Amazon S3 URL in the format
    /// s3://**/**.
    s3_url: []const u8,

    pub const json_field_names = .{
        .data_format = "DataFormat",
        .s3_url = "S3Url",
    };
};
