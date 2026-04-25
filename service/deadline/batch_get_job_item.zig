const aws = @import("aws");

const Attachments = @import("attachments.zig").Attachments;
const JobLifecycleStatus = @import("job_lifecycle_status.zig").JobLifecycleStatus;
const JobParameter = @import("job_parameter.zig").JobParameter;
const JobTargetTaskRunStatus = @import("job_target_task_run_status.zig").JobTargetTaskRunStatus;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;

/// The details of a job returned in a batch get operation.
pub const BatchGetJobItem = struct {
    /// The attachments for the job.
    attachments: ?Attachments = null,

    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The description of the job.
    description: ?[]const u8 = null,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The farm ID of the job.
    farm_id: []const u8,

    /// The job ID.
    job_id: []const u8,

    /// The life cycle status of the job.
    lifecycle_status: JobLifecycleStatus,

    /// A message that communicates the status of the life cycle.
    lifecycle_status_message: []const u8,

    /// The number of task failures before the job stops running and is marked as
    /// `FAILED`.
    max_failed_tasks_count: ?i32 = null,

    /// The maximum number of retries per failed tasks.
    max_retries_per_task: ?i32 = null,

    /// The maximum number of worker hosts that can concurrently process a job.
    max_worker_count: ?i32 = null,

    /// The name of the job.
    name: []const u8,

    /// The parameters for the job.
    parameters: ?[]const aws.map.MapEntry(JobParameter) = null,

    /// The job priority.
    priority: i32,

    /// The queue ID of the job.
    queue_id: []const u8,

    /// The job ID for the source job.
    source_job_id: ?[]const u8 = null,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The storage profile ID associated with the job.
    storage_profile_id: ?[]const u8 = null,

    /// The task status to start with on the job.
    target_task_run_status: ?JobTargetTaskRunStatus = null,

    /// The number of times that tasks failed and were retried.
    task_failure_retry_count: ?i32 = null,

    /// The task run status for the job.
    task_run_status: ?TaskRunStatus = null,

    /// The number of tasks for each run status for the job.
    task_run_status_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "attachments",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .ended_at = "endedAt",
        .farm_id = "farmId",
        .job_id = "jobId",
        .lifecycle_status = "lifecycleStatus",
        .lifecycle_status_message = "lifecycleStatusMessage",
        .max_failed_tasks_count = "maxFailedTasksCount",
        .max_retries_per_task = "maxRetriesPerTask",
        .max_worker_count = "maxWorkerCount",
        .name = "name",
        .parameters = "parameters",
        .priority = "priority",
        .queue_id = "queueId",
        .source_job_id = "sourceJobId",
        .started_at = "startedAt",
        .storage_profile_id = "storageProfileId",
        .target_task_run_status = "targetTaskRunStatus",
        .task_failure_retry_count = "taskFailureRetryCount",
        .task_run_status = "taskRunStatus",
        .task_run_status_counts = "taskRunStatusCounts",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
