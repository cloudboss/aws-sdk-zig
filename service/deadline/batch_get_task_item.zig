const aws = @import("aws");

const TaskParameterValue = @import("task_parameter_value.zig").TaskParameterValue;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;
const TaskTargetRunStatus = @import("task_target_run_status.zig").TaskTargetRunStatus;

/// The details of a task returned in a batch get operation.
pub const BatchGetTaskItem = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The number of times the task failed and was retried.
    failure_retry_count: ?i32 = null,

    /// The farm ID of the task.
    farm_id: []const u8,

    /// The job ID of the task.
    job_id: []const u8,

    /// The latest session action for the task.
    latest_session_action_id: ?[]const u8 = null,

    /// The parameters for the task.
    parameters: ?[]const aws.map.MapEntry(TaskParameterValue) = null,

    /// The queue ID of the task.
    queue_id: []const u8,

    /// The run status of the task.
    run_status: TaskRunStatus,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The step ID of the task.
    step_id: []const u8,

    /// The run status with which to start the task.
    target_run_status: ?TaskTargetRunStatus = null,

    /// The task ID.
    task_id: []const u8,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .ended_at = "endedAt",
        .failure_retry_count = "failureRetryCount",
        .farm_id = "farmId",
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
