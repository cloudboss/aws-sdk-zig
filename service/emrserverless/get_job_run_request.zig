pub const GetJobRunRequest = struct {
    /// The ID of the application on which the job run is submitted.
    application_id: []const u8,

    /// An optimal parameter that indicates the amount of attempts for the job. If
    /// not specified, this value defaults to the attempt of the latest job.
    attempt: ?i32 = null,

    /// The ID of the job run.
    job_run_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .attempt = "attempt",
        .job_run_id = "jobRunId",
    };
};
