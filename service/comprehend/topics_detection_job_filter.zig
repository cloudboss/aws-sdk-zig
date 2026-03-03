const JobStatus = @import("job_status.zig").JobStatus;

/// Provides information for filtering topic detection jobs. For more
/// information, see
/// .
pub const TopicsDetectionJobFilter = struct {
    job_name: ?[]const u8 = null,

    /// Filters the list of topic detection jobs based on job status. Returns only
    /// jobs with
    /// the specified status.
    job_status: ?JobStatus = null,

    /// Filters the list of jobs based on the time that the job was submitted for
    /// processing.
    /// Only returns jobs submitted after the specified time. Jobs are returned in
    /// ascending order,
    /// oldest to newest.
    submit_time_after: ?i64 = null,

    /// Filters the list of jobs based on the time that the job was submitted for
    /// processing.
    /// Only returns jobs submitted before the specified time. Jobs are returned in
    /// descending order,
    /// newest to oldest.
    submit_time_before: ?i64 = null,

    pub const json_field_names = .{
        .job_name = "JobName",
        .job_status = "JobStatus",
        .submit_time_after = "SubmitTimeAfter",
        .submit_time_before = "SubmitTimeBefore",
    };
};
