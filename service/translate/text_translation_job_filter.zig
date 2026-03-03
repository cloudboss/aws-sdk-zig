const JobStatus = @import("job_status.zig").JobStatus;

/// Provides information for filtering a list of translation jobs. For more
/// information, see
/// ListTextTranslationJobs.
pub const TextTranslationJobFilter = struct {
    /// Filters the list of jobs by name.
    job_name: ?[]const u8 = null,

    /// Filters the list of jobs based by job status.
    job_status: ?JobStatus = null,

    /// Filters the list of jobs based on the time that the job was submitted for
    /// processing and
    /// returns only the jobs submitted after the specified time. Jobs are returned
    /// in descending
    /// order, newest to oldest.
    submitted_after_time: ?i64 = null,

    /// Filters the list of jobs based on the time that the job was submitted for
    /// processing and
    /// returns only the jobs submitted before the specified time. Jobs are returned
    /// in ascending
    /// order, oldest to newest.
    submitted_before_time: ?i64 = null,

    pub const json_field_names = .{
        .job_name = "JobName",
        .job_status = "JobStatus",
        .submitted_after_time = "SubmittedAfterTime",
        .submitted_before_time = "SubmittedBeforeTime",
    };
};
