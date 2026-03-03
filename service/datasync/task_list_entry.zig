const TaskStatus = @import("task_status.zig").TaskStatus;
const TaskMode = @import("task_mode.zig").TaskMode;

/// Represents a single entry in a list of tasks. `TaskListEntry` returns an
/// array that contains a list of tasks when the
/// [ListTasks](https://docs.aws.amazon.com/datasync/latest/userguide/API_ListTasks.html) operation is called. A
/// task includes the source and destination file systems to sync and the
/// options to use for the
/// tasks.
pub const TaskListEntry = struct {
    /// The name of the task.
    name: ?[]const u8 = null,

    /// The status of the task.
    status: ?TaskStatus = null,

    /// The Amazon Resource Name (ARN) of the task.
    task_arn: ?[]const u8 = null,

    /// The task mode that you're using. For more information, see [Choosing a task
    /// mode for your data
    /// transfer](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
    task_mode: ?TaskMode = null,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
        .task_arn = "TaskArn",
        .task_mode = "TaskMode",
    };
};
