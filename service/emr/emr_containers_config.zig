/// The EMR container configuration.
pub const EMRContainersConfig = struct {
    /// The Job run ID for the container configuration.
    job_run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_run_id = "JobRunId",
    };
};
