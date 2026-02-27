const TaskStatusType = @import("task_status_type.zig").TaskStatusType;
const TaskType = @import("task_type.zig").TaskType;

/// The criteria that are used to filter the task runs for the machine learning
/// transform.
pub const TaskRunFilterCriteria = struct {
    /// Filter on task runs started after this date.
    started_after: ?i64,

    /// Filter on task runs started before this date.
    started_before: ?i64,

    /// The current status of the task run.
    status: ?TaskStatusType,

    /// The type of task run.
    task_run_type: ?TaskType,

    pub const json_field_names = .{
        .started_after = "StartedAfter",
        .started_before = "StartedBefore",
        .status = "Status",
        .task_run_type = "TaskRunType",
    };
};
