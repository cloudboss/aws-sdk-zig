const JobError = @import("job_error.zig").JobError;
const JobStatus = @import("job_status.zig").JobStatus;

/// Contains details about the policy generation request.
pub const JobDetails = struct {
    /// A timestamp of when the job was completed.
    completed_on: ?i64 = null,

    /// The job error for the policy generation request.
    job_error: ?JobError = null,

    /// The `JobId` that is returned by the `StartPolicyGeneration` operation. The
    /// `JobId` can be used with `GetGeneratedPolicy` to retrieve the generated
    /// policies or used with `CancelPolicyGeneration` to cancel the policy
    /// generation request.
    job_id: []const u8,

    /// A timestamp of when the job was started.
    started_on: i64,

    /// The status of the job request.
    status: JobStatus,

    pub const json_field_names = .{
        .completed_on = "completedOn",
        .job_error = "jobError",
        .job_id = "jobId",
        .started_on = "startedOn",
        .status = "status",
    };
};
