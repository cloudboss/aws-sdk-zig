/// Records a successful request to stop a specified `JobRun`.
pub const BatchStopJobRunSuccessfulSubmission = struct {
    /// The name of the job definition used in the job run that was stopped.
    job_name: ?[]const u8 = null,

    /// The `JobRunId` of the job run that was stopped.
    job_run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_name = "JobName",
        .job_run_id = "JobRunId",
    };
};
