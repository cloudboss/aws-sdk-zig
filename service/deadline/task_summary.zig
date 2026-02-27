const aws = @import("aws");

const TaskParameterValue = @import("task_parameter_value.zig").TaskParameterValue;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;
const TaskTargetRunStatus = @import("task_target_run_status.zig").TaskTargetRunStatus;

/// The details of a task.
pub const TaskSummary = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The date and time the resource ended running.
    ended_at: ?i64,

    /// The number of times that the task failed and was retried.
    failure_retry_count: ?i32,

    /// The latest session action ID for the task.
    latest_session_action_id: ?[]const u8,

    /// The task parameters.
    parameters: ?[]const aws.map.MapEntry(TaskParameterValue),

    /// The run status of the task.
    run_status: TaskRunStatus,

    /// The date and time the resource started running.
    started_at: ?i64,

    /// The run status on which the started.
    target_run_status: ?TaskTargetRunStatus,

    /// The task ID.
    task_id: []const u8,

    /// The date and time the resource was updated.
    updated_at: ?i64,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .ended_at = "endedAt",
        .failure_retry_count = "failureRetryCount",
        .latest_session_action_id = "latestSessionActionId",
        .parameters = "parameters",
        .run_status = "runStatus",
        .started_at = "startedAt",
        .target_run_status = "targetRunStatus",
        .task_id = "taskId",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
