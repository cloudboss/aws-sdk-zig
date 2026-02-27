const TaskInstanceStatus = @import("task_instance_status.zig").TaskInstanceStatus;

/// Summary information about a task instance within a workflow run, including
/// its status and execution details.
pub const TaskInstanceSummary = struct {
    /// The duration of the task instance execution in seconds. This value is null
    /// if the task is not complete.
    duration_in_seconds: ?i32,

    /// The name of the Apache Airflow operator used for this task instance.
    operator_name: ?[]const u8,

    /// The unique identifier of the workflow run that contains this task instance.
    run_id: ?[]const u8,

    /// The current status of the task instance.
    status: ?TaskInstanceStatus,

    /// The unique identifier of this task instance.
    task_instance_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the workflow that contains this task
    /// instance.
    workflow_arn: ?[]const u8,

    /// The version of the workflow that contains this task instance.
    workflow_version: ?[]const u8,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
        .operator_name = "OperatorName",
        .run_id = "RunId",
        .status = "Status",
        .task_instance_id = "TaskInstanceId",
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
    };
};
