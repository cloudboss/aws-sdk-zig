/// A run identifier.
pub const RunIdentifier = struct {
    /// The Job Run ID.
    job_run_id: ?[]const u8 = null,

    /// The Run ID.
    run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_run_id = "JobRunId",
        .run_id = "RunId",
    };
};
