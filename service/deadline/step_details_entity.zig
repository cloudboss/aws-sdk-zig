/// The details of a step entity.
pub const StepDetailsEntity = struct {
    /// The dependencies for a step.
    dependencies: []const []const u8,

    /// The job ID.
    job_id: []const u8,

    /// The schema version for a step template.
    schema_version: []const u8,

    /// The step ID.
    step_id: []const u8,

    /// The template for a step.
    template: []const u8,

    pub const json_field_names = .{
        .dependencies = "dependencies",
        .job_id = "jobId",
        .schema_version = "schemaVersion",
        .step_id = "stepId",
        .template = "template",
    };
};
