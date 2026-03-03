const DataDestination = @import("data_destination.zig").DataDestination;

/// Provides a summary of the forecast export job properties used in the
/// ListForecastExportJobs operation. To get the complete set of properties,
/// call
/// the DescribeForecastExportJob operation, and provide the listed
/// `ForecastExportJobArn`.
pub const ForecastExportJobSummary = struct {
    /// When the forecast export job was created.
    creation_time: ?i64 = null,

    /// The path to the Amazon Simple Storage Service (Amazon S3) bucket where the
    /// forecast is exported.
    destination: ?DataDestination = null,

    /// The Amazon Resource Name (ARN) of the forecast export job.
    forecast_export_job_arn: ?[]const u8 = null,

    /// The name of the forecast export job.
    forecast_export_job_name: ?[]const u8 = null,

    /// The last time the resource was modified. The timestamp depends on the status
    /// of the job:
    ///
    /// * `CREATE_PENDING` - The `CreationTime`.
    ///
    /// * `CREATE_IN_PROGRESS` - The current timestamp.
    ///
    /// * `CREATE_STOPPING` - The current timestamp.
    ///
    /// * `CREATE_STOPPED` - When the job stopped.
    ///
    /// * `ACTIVE` or `CREATE_FAILED` - When the job finished or
    /// failed.
    last_modification_time: ?i64 = null,

    /// If an error occurred, an informational message about the error.
    message: ?[]const u8 = null,

    /// The status of the forecast export job. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `CREATE_STOPPING`, `CREATE_STOPPED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    ///
    /// The `Status` of the forecast export job must be `ACTIVE` before
    /// you can access the forecast in your S3 bucket.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .destination = "Destination",
        .forecast_export_job_arn = "ForecastExportJobArn",
        .forecast_export_job_name = "ForecastExportJobName",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .status = "Status",
    };
};
