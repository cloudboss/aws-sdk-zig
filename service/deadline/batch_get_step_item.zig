const aws = @import("aws");

const DependencyCounts = @import("dependency_counts.zig").DependencyCounts;
const StepLifecycleStatus = @import("step_lifecycle_status.zig").StepLifecycleStatus;
const ParameterSpace = @import("parameter_space.zig").ParameterSpace;
const StepRequiredCapabilities = @import("step_required_capabilities.zig").StepRequiredCapabilities;
const StepTargetTaskRunStatus = @import("step_target_task_run_status.zig").StepTargetTaskRunStatus;
const TaskRunStatus = @import("task_run_status.zig").TaskRunStatus;

/// The details of a step returned in a batch get operation.
pub const BatchGetStepItem = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The number of dependencies for the step.
    dependency_counts: ?DependencyCounts = null,

    /// The description of the step.
    description: ?[]const u8 = null,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The farm ID of the step.
    farm_id: []const u8,

    /// The job ID of the step.
    job_id: []const u8,

    /// The life cycle status of the step.
    lifecycle_status: StepLifecycleStatus,

    /// A message that communicates the status of the life cycle.
    lifecycle_status_message: ?[]const u8 = null,

    /// The name of the step.
    name: []const u8,

    /// The parameter space for the step.
    parameter_space: ?ParameterSpace = null,

    /// The queue ID of the step.
    queue_id: []const u8,

    /// The required capabilities for the step.
    required_capabilities: ?StepRequiredCapabilities = null,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The step ID.
    step_id: []const u8,

    /// The task status to start with on the step.
    target_task_run_status: ?StepTargetTaskRunStatus = null,

    /// The number of times that tasks failed and were retried.
    task_failure_retry_count: ?i32 = null,

    /// The task run status for the step.
    task_run_status: TaskRunStatus,

    /// The number of tasks for each run status for the step.
    task_run_status_counts: []const aws.map.MapEntry(i32),

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .dependency_counts = "dependencyCounts",
        .description = "description",
        .ended_at = "endedAt",
        .farm_id = "farmId",
        .job_id = "jobId",
        .lifecycle_status = "lifecycleStatus",
        .lifecycle_status_message = "lifecycleStatusMessage",
        .name = "name",
        .parameter_space = "parameterSpace",
        .queue_id = "queueId",
        .required_capabilities = "requiredCapabilities",
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
