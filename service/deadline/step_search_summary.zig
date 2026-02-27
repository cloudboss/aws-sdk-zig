const aws = @import("aws");

const StepLifecycleStatus = @import("step_lifecycle_status.zig").StepLifecycleStatus;
const ParameterSpace = @import("parameter_space.zig").ParameterSpace;
const StepTargetTaskRunStatus = @import("step_target_task_run_status.zig").StepTargetTaskRunStatus;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;

/// The details of a step search.
pub const StepSearchSummary = struct {
    /// The date and time the resource was created.
    created_at: ?i64,

    /// The user or system that created this resource.
    created_by: ?[]const u8,

    /// The date and time the resource ended running.
    ended_at: ?i64,

    /// The job ID.
    job_id: ?[]const u8,

    /// The life cycle status.
    lifecycle_status: ?StepLifecycleStatus,

    /// The life cycle status message.
    lifecycle_status_message: ?[]const u8,

    /// The step name.
    name: ?[]const u8,

    /// The parameters and combination expressions for the search.
    parameter_space: ?ParameterSpace,

    /// The queue ID.
    queue_id: ?[]const u8,

    /// The date and time the resource started running.
    started_at: ?i64,

    /// The step ID.
    step_id: ?[]const u8,

    /// The task status to update the job's tasks to.
    target_task_run_status: ?StepTargetTaskRunStatus,

    /// The total number of times tasks from the step failed and were retried.
    task_failure_retry_count: ?i32,

    /// The task run status for the job.
    ///
    /// * `PENDING`–pending and waiting for resources.
    /// * `READY`–ready to be processed.
    /// * `ASSIGNED`–assigned and will run next on a worker.
    /// * `SCHEDULED`–scheduled to be run on a worker.
    /// * `INTERRUPTING`–being interrupted.
    /// * `RUNNING`–running on a worker.
    /// * `SUSPENDED`–the task is suspended.
    /// * `CANCELED`–the task has been canceled.
    /// * `FAILED`–the task has failed.
    /// * `SUCCEEDED`–the task has succeeded.
    task_run_status: ?TaskRunStatus,

    /// The number of tasks running on the job.
    task_run_status_counts: ?[]const aws.map.MapEntry(i32),

    /// The date and time the resource was updated.
    updated_at: ?i64,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .ended_at = "endedAt",
        .job_id = "jobId",
        .lifecycle_status = "lifecycleStatus",
        .lifecycle_status_message = "lifecycleStatusMessage",
        .name = "name",
        .parameter_space = "parameterSpace",
        .queue_id = "queueId",
        .started_at = "startedAt",
        .step_id = "stepId",
        .target_task_run_status = "targetTaskRunStatus",
        .task_failure_retry_count = "taskFailureRetryCount",
        .task_run_status = "taskRunStatus",
        .task_run_status_counts = "taskRunStatusCounts",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
