const JobStatus = @import("job_status.zig").JobStatus;

/// Provides information for filtering a list of dominant language detection
/// jobs. For more
/// information, see the operation.
pub const EntitiesDetectionJobFilter = struct {
    /// Filters on the name of the job.
    job_name: ?[]const u8 = null,

    /// Filters the list of jobs based on job status. Returns only jobs with the
    /// specified
    /// status.
    job_status: ?JobStatus = null,

    /// Filters the list of jobs based on the time that the job was submitted for
    /// processing.
    /// Returns only jobs submitted after the specified time. Jobs are returned in
    /// descending order,
    /// newest to oldest.
    submit_time_after: ?i64 = null,

    /// Filters the list of jobs based on the time that the job was submitted for
    /// processing.
    /// Returns only jobs submitted before the specified time. Jobs are returned in
    /// ascending order,
    /// oldest to newest.
    submit_time_before: ?i64 = null,

    pub const json_field_names = .{
        .job_name = "JobName",
        .job_status = "JobStatus",
        .submit_time_after = "SubmitTimeAfter",
        .submit_time_before = "SubmitTimeBefore",
    };
};
