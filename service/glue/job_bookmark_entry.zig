/// Defines a point that a job can resume processing.
pub const JobBookmarkEntry = struct {
    /// The attempt ID number.
    attempt: i32 = 0,

    /// The bookmark itself.
    job_bookmark: ?[]const u8,

    /// The name of the job in question.
    job_name: ?[]const u8,

    /// The unique run identifier associated with the previous job run.
    previous_run_id: ?[]const u8,

    /// The run ID number.
    run: i32 = 0,

    /// The run ID number.
    run_id: ?[]const u8,

    /// The version of the job.
    version: i32 = 0,

    pub const json_field_names = .{
        .attempt = "Attempt",
        .job_bookmark = "JobBookmark",
        .job_name = "JobName",
        .previous_run_id = "PreviousRunId",
        .run = "Run",
        .run_id = "RunId",
        .version = "Version",
    };
};
