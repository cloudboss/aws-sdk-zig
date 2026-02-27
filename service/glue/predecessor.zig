/// A job run that was used in the predicate of a conditional trigger
/// that triggered this job run.
pub const Predecessor = struct {
    /// The name of the job definition used by the predecessor job run.
    job_name: ?[]const u8,

    /// The job-run ID of the predecessor job run.
    run_id: ?[]const u8,

    pub const json_field_names = .{
        .job_name = "JobName",
        .run_id = "RunId",
    };
};
