/// The identifiers for a job.
pub const JobDetailsIdentifiers = struct {
    /// The job ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
    };
};
