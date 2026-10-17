const DataFormat = @import("data_format.zig").DataFormat;

/// An object that contains details about the destination of the export job.
///
/// When you create an export job, specify only `DataFormat`. SES
/// writes the export file to a location that it manages. After the job
/// completes, call
/// `GetExportJob` and use the `S3Url` that's returned to download
/// the file. To store a copy in your own Amazon S3 bucket, upload the
/// downloaded file to your
/// bucket. Do not include `S3Url` in the `CreateExportJob` request.
pub const ExportDestination = struct {
    /// The data format of the final export job file, can be one of the following:
    ///
    /// * `CSV` - A comma-separated values file.
    ///
    /// * `JSON` - A Json file.
    data_format: DataFormat,

    /// An Amazon S3 pre-signed URL that points to the generated export file.
    ///
    /// SES sets this value. It's returned only in the `GetExportJob`
    /// response, after the export job status is `COMPLETED`. The URL expires five
    /// minutes after `GetExportJob` returns it. Call `GetExportJob` again
    /// to get a new URL. If you include this field in a `CreateExportJob` request,
    /// the request fails with a `BadRequestException`.
    s3_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_format = "DataFormat",
        .s3_url = "S3Url",
    };
};
