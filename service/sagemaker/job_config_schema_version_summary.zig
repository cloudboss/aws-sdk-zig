/// Provides summary information about a job configuration schema version.
pub const JobConfigSchemaVersionSummary = struct {
    /// The version of the job configuration schema.
    job_config_schema_version: []const u8,

    pub const json_field_names = .{
        .job_config_schema_version = "JobConfigSchemaVersion",
    };
};
