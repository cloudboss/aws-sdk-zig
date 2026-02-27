/// The details of identifiers for a step.
pub const StepDetailsIdentifiers = struct {
    /// The job ID.
    job_id: []const u8,

    /// The step ID.
    step_id: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
        .step_id = "stepId",
    };
};
