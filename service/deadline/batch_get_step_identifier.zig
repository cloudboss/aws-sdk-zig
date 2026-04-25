/// The identifiers for a step.
pub const BatchGetStepIdentifier = struct {
    /// The farm ID of the step.
    farm_id: []const u8,

    /// The job ID of the step.
    job_id: []const u8,

    /// The queue ID of the step.
    queue_id: []const u8,

    /// The step ID.
    step_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
        .step_id = "stepId",
    };
};
