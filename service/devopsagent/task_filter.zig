const Priority = @import("priority.zig").Priority;
const TaskStatus = @import("task_status.zig").TaskStatus;
const TaskType = @import("task_type.zig").TaskType;

/// Filter criteria for listing backlog tasks, supporting time range, priority,
/// status, and type filters.
pub const TaskFilter = struct {
    /// Filter for tasks created after this timestamp inclusive
    created_after: ?i64 = null,

    /// Filter for tasks created before this timestamp exclusive
    created_before: ?i64 = null,

    /// Filter by primary task ID to get linked tasks
    primary_task_id: ?[]const u8 = null,

    /// Filter by priority (single value only)
    priority: ?[]const Priority = null,

    /// Filter by status (single value only)
    status: ?[]const TaskStatus = null,

    /// Filter by task type (single value only)
    task_type: ?[]const TaskType = null,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .primary_task_id = "primaryTaskId",
        .priority = "priority",
        .status = "status",
        .task_type = "taskType",
    };
};
