const UpdateJobLifecycleStatus = @import("update_job_lifecycle_status.zig").UpdateJobLifecycleStatus;
const JobTargetTaskRunStatus = @import("job_target_task_run_status.zig").JobTargetTaskRunStatus;

/// The details of a job to update in a batch update operation.
pub const BatchUpdateJobItem = struct {
    /// The description of the job to update.
    description: ?[]const u8 = null,

    /// The farm ID of the job to update.
    farm_id: []const u8,

    /// The job ID of the job to update.
    job_id: []const u8,

    /// The status of a job in its lifecycle. When you change the status of the job
    /// to `ARCHIVED`, the job can't be scheduled or archived.
    ///
    /// An archived job and its steps and tasks are deleted after 120 days. The job
    /// can't be recovered.
    lifecycle_status: ?UpdateJobLifecycleStatus = null,

    /// The number of task failures before the job stops running and is marked as
    /// `FAILED`.
    max_failed_tasks_count: ?i32 = null,

    /// The maximum number of retries per failed tasks.
    max_retries_per_task: ?i32 = null,

    /// The maximum number of worker hosts that can concurrently process a job.
    max_worker_count: ?i32 = null,

    /// The name of the job to update.
    name: ?[]const u8 = null,

    /// The job priority to update.
    priority: ?i32 = null,

    /// The queue ID of the job to update.
    queue_id: []const u8,

    /// The task status to update the job's tasks to.
    target_task_run_status: ?JobTargetTaskRunStatus = null,

    pub const json_field_names = .{
        .description = "description",
        .farm_id = "farmId",
        .job_id = "jobId",
        .lifecycle_status = "lifecycleStatus",
        .max_failed_tasks_count = "maxFailedTasksCount",
        .max_retries_per_task = "maxRetriesPerTask",
        .max_worker_count = "maxWorkerCount",
        .name = "name",
        .priority = "priority",
        .queue_id = "queueId",
        .target_task_run_status = "targetTaskRunStatus",
    };
};
