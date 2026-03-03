const aws = @import("aws");

const JobParameter = @import("job_parameter.zig").JobParameter;
const JobLifecycleStatus = @import("job_lifecycle_status.zig").JobLifecycleStatus;
const JobTargetTaskRunStatus = @import("job_target_task_run_status.zig").JobTargetTaskRunStatus;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;

/// The details of a job search.
pub const JobSearchSummary = struct {
    /// The date and time the resource was created.
    created_at: ?i64 = null,

    /// The user or system that created this resource.
    created_by: ?[]const u8 = null,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The job ID.
    job_id: ?[]const u8 = null,

    /// The job parameters.
    job_parameters: ?[]const aws.map.MapEntry(JobParameter) = null,

    /// The life cycle status.
    lifecycle_status: ?JobLifecycleStatus = null,

    /// The life cycle status message.
    lifecycle_status_message: ?[]const u8 = null,

    /// The number of task failures before the job stops running and is marked as
    /// `FAILED`.
    max_failed_tasks_count: ?i32 = null,

    /// The maximum number of retries for a job.
    max_retries_per_task: ?i32 = null,

    /// The maximum number of worker hosts that can concurrently process a job. When
    /// the `maxWorkerCount` is reached, no more workers will be assigned to process
    /// the job, even if the fleets assigned to the job's queue has available
    /// workers.
    ///
    /// You can't set the `maxWorkerCount` to 0. If you set it to -1, there is no
    /// maximum number of workers.
    ///
    /// If you don't specify the `maxWorkerCount`, the default is -1.
    max_worker_count: ?i32 = null,

    /// The job name.
    name: ?[]const u8 = null,

    /// The job priority.
    priority: ?i32 = null,

    /// The queue ID.
    queue_id: ?[]const u8 = null,

    /// The job ID for the source job.
    source_job_id: ?[]const u8 = null,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The task status to update the job's tasks to.
    target_task_run_status: ?JobTargetTaskRunStatus = null,

    /// The total number of times tasks from the job failed and were retried.
    task_failure_retry_count: ?i32 = null,

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
    task_run_status: ?TaskRunStatus = null,

    /// The number of tasks running on the job.
    task_run_status_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .ended_at = "endedAt",
        .job_id = "jobId",
        .job_parameters = "jobParameters",
        .lifecycle_status = "lifecycleStatus",
        .lifecycle_status_message = "lifecycleStatusMessage",
        .max_failed_tasks_count = "maxFailedTasksCount",
        .max_retries_per_task = "maxRetriesPerTask",
        .max_worker_count = "maxWorkerCount",
        .name = "name",
        .priority = "priority",
        .queue_id = "queueId",
        .source_job_id = "sourceJobId",
        .started_at = "startedAt",
        .target_task_run_status = "targetTaskRunStatus",
        .task_failure_retry_count = "taskFailureRetryCount",
        .task_run_status = "taskRunStatus",
        .task_run_status_counts = "taskRunStatusCounts",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
