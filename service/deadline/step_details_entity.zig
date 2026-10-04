/// The details of a step entity.
pub const StepDetailsEntity = struct {
    /// The dependencies for a step.
    dependencies: []const []const u8,

    /// The Open Job Description extensions that the step uses. This value is used
    /// by the worker agent.
    extensions: ?[]const []const u8 = null,

    /// The job ID.
    job_id: []const u8,

    /// The resolved symbol table for the step's expressions, serialized as JSON.
    /// This value is used by the worker agent.
    resolved_symbol_table: ?[]const u8 = null,

    /// The schema version for a step template.
    schema_version: []const u8,

    /// The step ID.
    step_id: []const u8,

    /// The template for a step.
    template: []const u8,

    pub const json_field_names = .{
        .dependencies = "dependencies",
        .extensions = "extensions",
        .job_id = "jobId",
        .resolved_symbol_table = "resolvedSymbolTable",
        .schema_version = "schemaVersion",
        .step_id = "stepId",
        .template = "template",
    };
};
