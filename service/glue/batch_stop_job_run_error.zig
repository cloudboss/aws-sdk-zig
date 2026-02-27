const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// Records an error that occurred when attempting to stop a
/// specified job run.
pub const BatchStopJobRunError = struct {
    /// Specifies details about the error that was encountered.
    error_detail: ?ErrorDetail,

    /// The name of the job definition that is used in the job run in question.
    job_name: ?[]const u8,

    /// The `JobRunId` of the job run in question.
    job_run_id: ?[]const u8,

    pub const json_field_names = .{
        .error_detail = "ErrorDetail",
        .job_name = "JobName",
        .job_run_id = "JobRunId",
    };
};
