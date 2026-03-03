const aws = @import("aws");

const DependencyCounts = @import("dependency_counts.zig").DependencyCounts;
const StepLifecycleStatus = @import("step_lifecycle_status.zig").StepLifecycleStatus;
const StepTargetTaskRunStatus = @import("step_target_task_run_status.zig").StepTargetTaskRunStatus;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;

/// The details for a step.
pub const StepSummary = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The number of dependencies for the step.
    dependency_counts: ?DependencyCounts = null,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The life cycle status.
    lifecycle_status: StepLifecycleStatus,

    /// A message that describes the lifecycle of the step.
    lifecycle_status_message: ?[]const u8 = null,

    /// The name of the step.
    name: []const u8,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The step ID.
    step_id: []const u8,

    /// The task status to update the job's tasks to.
    target_task_run_status: ?StepTargetTaskRunStatus = null,

    /// The total number of times tasks from the step failed and were retried.
    task_failure_retry_count: ?i32 = null,

    /// The task run status for the job.
    ///
    /// * `PENDING`–pending and waiting for resources.
    /// * `READY`–ready to process.
    /// * `ASSIGNED`–assigned and will run next on a worker.
    /// * `SCHEDULED`–scheduled to run on a worker.
    /// * `INTERRUPTING`–being interrupted.
    /// * `RUNNING`–running on a worker.
    /// * `SUSPENDED`–the task is suspended.
    /// * `CANCELED`–the task has been canceled.
    /// * `FAILED`–the task has failed.
    /// * `SUCCEEDED`–the task has succeeded.
    task_run_status: TaskRunStatus,

    /// The number of tasks running on the job.
    task_run_status_counts: []const aws.map.MapEntry(i32),

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .dependency_counts = "dependencyCounts",
        .ended_at = "endedAt",
        .lifecycle_status = "lifecycleStatus",
        .lifecycle_status_message = "lifecycleStatusMessage",
        .name = "name",
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
