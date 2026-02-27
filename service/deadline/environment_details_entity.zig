/// The details of a specified environment.
pub const EnvironmentDetailsEntity = struct {
    /// The environment ID.
    environment_id: []const u8,

    /// The job ID.
    job_id: []const u8,

    /// The schema version in the environment.
    schema_version: []const u8,

    /// The template used for the environment.
    template: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .job_id = "jobId",
        .schema_version = "schemaVersion",
        .template = "template",
    };
};
