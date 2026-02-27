/// The IDs of the job and environment.
pub const EnvironmentDetailsIdentifiers = struct {
    /// The environment ID.
    environment_id: []const u8,

    /// The job ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .job_id = "jobId",
    };
};
