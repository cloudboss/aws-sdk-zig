const JobStatus = @import("job_status.zig").JobStatus;

/// Criteria for filtering jobs.
pub const JobsFilter = struct {
    /// Filter by job status.
    job_status: ?JobStatus = null,

    pub const json_field_names = .{
        .job_status = "JobStatus",
    };
};
