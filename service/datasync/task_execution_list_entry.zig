const TaskExecutionStatus = @import("task_execution_status.zig").TaskExecutionStatus;
const TaskMode = @import("task_mode.zig").TaskMode;

/// Represents a single entry in a list of DataSync task executions that's
/// returned with the
/// [ListTaskExecutions](https://docs.aws.amazon.com/datasync/latest/userguide/API_ListTaskExecutions.html)
/// operation.
pub const TaskExecutionListEntry = struct {
    /// The status of a task execution. For more information, see [Task execution
    /// statuses](https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#understand-task-execution-statuses).
    status: ?TaskExecutionStatus,

    /// The Amazon Resource Name (ARN) of a task execution.
    task_execution_arn: ?[]const u8,

    /// The task mode that you're using. For more information, see [Choosing a task
    /// mode for your data
    /// transfer](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    task_mode: ?TaskMode,

    pub const json_field_names = .{
        .status = "Status",
        .task_execution_arn = "TaskExecutionArn",
        .task_mode = "TaskMode",
    };
};
