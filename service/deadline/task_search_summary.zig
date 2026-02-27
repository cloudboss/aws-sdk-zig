const aws = @import("aws");

const TaskParameterValue = @import("task_parameter_value.zig").TaskParameterValue;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;
const TaskTargetRunStatus = @import("task_target_run_status.zig").TaskTargetRunStatus;

/// The details of a task search.
pub const TaskSearchSummary = struct {
    /// The date and time the resource ended running.
    ended_at: ?i64,

    /// The number of times that the task failed and was retried.
    failure_retry_count: ?i32,

    /// The job ID.
    job_id: ?[]const u8,

    /// The latest session action ID for the task.
    latest_session_action_id: ?[]const u8,

    /// The parameters to search for.
    parameters: ?[]const aws.map.MapEntry(TaskParameterValue),

    /// The queue ID.
    queue_id: ?[]const u8,

    /// The run status of the task.
    run_status: ?TaskRunStatus,

    /// The date and time the resource started running.
    started_at: ?i64,

    /// The step ID.
    step_id: ?[]const u8,

    /// The run status that the task is being updated to.
    target_run_status: ?TaskTargetRunStatus,

    /// The task ID.
    task_id: ?[]const u8,

    /// The date and time the resource was updated.
    updated_at: ?i64,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .ended_at = "endedAt",
        .failure_retry_count = "failureRetryCount",
        .job_id = "jobId",
        .latest_session_action_id = "latestSessionActionId",
        .parameters = "parameters",
        .queue_id = "queueId",
        .run_status = "runStatus",
        .started_at = "startedAt",
        .step_id = "stepId",
        .target_run_status = "targetRunStatus",
        .task_id = "taskId",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
