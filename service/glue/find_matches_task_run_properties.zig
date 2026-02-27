/// Specifies configuration properties for a Find Matches task run.
pub const FindMatchesTaskRunProperties = struct {
    /// The job ID for the Find Matches task run.
    job_id: ?[]const u8,

    /// The name assigned to the job for the Find Matches task run.
    job_name: ?[]const u8,

    /// The job run ID for the Find Matches task run.
    job_run_id: ?[]const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
        .job_name = "JobName",
        .job_run_id = "JobRunId",
    };
};
