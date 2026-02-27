const JobStatus = @import("job_status.zig").JobStatus;

/// Contains the job summary information.
pub const JobSummary = struct {
    /// The ID of the job.
    id: []const u8,

    /// The unique name that helps identify the job request.
    name: []const u8,

    /// The status of the bulk import job can be one of following values:
    ///
    /// * `PENDING` – IoT SiteWise is waiting for the current bulk import job to
    ///   finish.
    ///
    /// * `CANCELLED` – The bulk import job has been canceled.
    ///
    /// * `RUNNING` – IoT SiteWise is processing your request to import your data
    ///   from Amazon S3.
    ///
    /// * `COMPLETED` – IoT SiteWise successfully completed your request to import
    ///   data from Amazon S3.
    ///
    /// * `FAILED` – IoT SiteWise couldn't process your request to import data from
    ///   Amazon S3.
    /// You can use logs saved in the specified error report location in Amazon S3
    /// to troubleshoot issues.
    ///
    /// * `COMPLETED_WITH_FAILURES` – IoT SiteWise completed your request to import
    ///   data from Amazon S3 with errors.
    /// You can use logs saved in the specified error report location in Amazon S3
    /// to troubleshoot issues.
    status: JobStatus,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
