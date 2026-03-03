const JobRunError = @import("job_run_error.zig").JobRunError;
const JobType = @import("job_type.zig").JobType;
const JobRunMode = @import("job_run_mode.zig").JobRunMode;
const JobRunStatus = @import("job_run_status.zig").JobRunStatus;

/// The job run summary.
pub const JobRunSummary = struct {
    /// The timestamp at which job run was created.
    created_at: ?i64 = null,

    /// The user who created the job run.
    created_by: ?[]const u8 = null,

    /// The domain ID of the job run.
    domain_id: ?[]const u8 = null,

    /// The end time of a job run.
    end_time: ?i64 = null,

    /// The error of a job run.
    @"error": ?JobRunError = null,

    /// The job ID of a job run.
    job_id: ?[]const u8 = null,

    /// The job type of a job run.
    job_type: ?JobType = null,

    /// The run ID of a job run.
    run_id: ?[]const u8 = null,

    /// The run mode of a job run.
    run_mode: ?JobRunMode = null,

    /// The start time of a job run.
    start_time: ?i64 = null,

    /// The status of a job run.
    status: ?JobRunStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .end_time = "endTime",
        .@"error" = "error",
        .job_id = "jobId",
        .job_type = "jobType",
        .run_id = "runId",
        .run_mode = "runMode",
        .start_time = "startTime",
        .status = "status",
    };
};
