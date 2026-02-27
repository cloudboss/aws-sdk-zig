const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;
const RunType = @import("run_type.zig").RunType;

/// Detailed information about a workflow run execution, including timing,
/// status, error information, and associated task instances. This structure
/// provides comprehensive visibility into the workflow execution lifecycle
/// within the Amazon Managed Workflows for Apache Airflow Serverless serverless
/// environment. The service tracks execution across distributed ECS worker
/// tasks and provides detailed timing information, error diagnostics, and task
/// instance relationships to support effective monitoring and troubleshooting
/// of complex workflow executions.
pub const WorkflowRunDetail = struct {
    /// The timestamp when the workflow run completed execution, in ISO 8601
    /// date-time format. This value is null if the run is not complete.
    completed_on: ?i64,

    /// The timestamp when the workflow run was created, in ISO 8601 date-time
    /// format.
    created_at: ?i64,

    /// The total duration of the workflow run execution in seconds. This value is
    /// null if the run is not complete.
    duration: ?i32,

    /// The error message if the workflow run failed. This value is null if the run
    /// completed successfully.
    error_message: ?[]const u8,

    /// The timestamp when the workflow run was last modified, in ISO 8601 date-time
    /// format.
    modified_at: ?i64,

    /// The unique identifier of this workflow run.
    run_id: ?[]const u8,

    /// The current execution state of the workflow run.
    run_state: ?WorkflowRunStatus,

    /// The type of workflow run.
    run_type: ?RunType,

    /// The timestamp when the workflow run started execution, in ISO 8601 date-time
    /// format.
    started_on: ?i64,

    /// A list of task instance IDs that are part of this workflow run.
    task_instances: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the workflow that contains this run.
    workflow_arn: ?[]const u8,

    /// The version of the workflow used for this run.
    workflow_version: ?[]const u8,

    pub const json_field_names = .{
        .completed_on = "CompletedOn",
        .created_at = "CreatedAt",
        .duration = "Duration",
        .error_message = "ErrorMessage",
        .modified_at = "ModifiedAt",
        .run_id = "RunId",
        .run_state = "RunState",
        .run_type = "RunType",
        .started_on = "StartedOn",
        .task_instances = "TaskInstances",
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
    };
};
