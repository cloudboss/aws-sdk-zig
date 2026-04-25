/// The identifiers for a task.
pub const BatchGetTaskIdentifier = struct {
    /// The farm ID of the task.
    farm_id: []const u8,

    /// The job ID of the task.
    job_id: []const u8,

    /// The queue ID of the task.
    queue_id: []const u8,

    /// The step ID of the task.
    step_id: []const u8,

    /// The task ID.
    task_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
        .step_id = "stepId",
        .task_id = "taskId",
    };
};
