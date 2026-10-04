/// The details of a specified environment.
pub const EnvironmentDetailsEntity = struct {
    /// The environment ID.
    environment_id: []const u8,

    /// The Open Job Description extensions that the environment uses. This value is
    /// used by the worker agent.
    extensions: ?[]const []const u8 = null,

    /// The job ID.
    job_id: []const u8,

    /// The resolved symbol table for the environment's expressions, serialized as
    /// JSON. This value is used by the worker agent.
    resolved_symbol_table: ?[]const u8 = null,

    /// The schema version in the environment.
    schema_version: []const u8,

    /// The template used for the environment.
    template: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .extensions = "extensions",
        .job_id = "jobId",
        .resolved_symbol_table = "resolvedSymbolTable",
        .schema_version = "schemaVersion",
        .template = "template",
    };
};
