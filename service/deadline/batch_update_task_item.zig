const TaskTargetRunStatus = @import("task_target_run_status.zig").TaskTargetRunStatus;

/// The details of a task to update in a batch update operation.
pub const BatchUpdateTaskItem = struct {
    /// The farm ID of the task to update.
    farm_id: []const u8,

    /// The job ID of the task to update.
    job_id: []const u8,

    /// The queue ID of the task to update.
    queue_id: []const u8,

    /// The step ID of the task to update.
    step_id: []const u8,

    /// The run status with which to start the task.
    target_run_status: TaskTargetRunStatus,

    /// The task ID of the task to update.
    task_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
        .step_id = "stepId",
        .target_run_status = "targetRunStatus",
        .task_id = "taskId",
    };
};
