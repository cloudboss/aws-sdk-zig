/// A run identifier.
pub const RunIdentifier = struct {
    /// The Job Run ID.
    job_run_id: ?[]const u8,

    /// The Run ID.
    run_id: ?[]const u8,

    pub const json_field_names = .{
        .job_run_id = "JobRunId",
        .run_id = "RunId",
    };
};
