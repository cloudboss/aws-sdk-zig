const Priority = @import("priority.zig").Priority;
const ReferenceOutput = @import("reference_output.zig").ReferenceOutput;
const TaskStatus = @import("task_status.zig").TaskStatus;
const TaskType = @import("task_type.zig").TaskType;

/// Represents a backlog task with all its properties and metadata
pub const Task = struct {
    /// The unique identifier for the agent space containing this task
    agent_space_id: []const u8,

    /// Timestamp when this task was created
    created_at: i64,

    /// Optional detailed description of the task
    description: ?[]const u8 = null,

    /// The execution ID associated with this task, if any
    execution_id: ?[]const u8 = null,

    /// Indicates if this task has other tasks linked to it
    has_linked_tasks: bool = false,

    /// Optional metadata for the task
    metadata: ?[]const u8 = null,

    /// The task ID of the primary investigation this task is linked to
    primary_task_id: ?[]const u8 = null,

    /// The priority level of this task
    priority: Priority,

    /// Optional reference information linking this task to external systems
    reference: ?ReferenceOutput = null,

    /// The current status of this task
    status: TaskStatus,

    /// Explanation for why the task status was changed (e.g., linked reason)
    status_reason: ?[]const u8 = null,

    /// Optional support metadata for the task
    support_metadata: ?[]const u8 = null,

    /// The unique identifier for this task
    task_id: []const u8,

    /// The type of this task
    task_type: TaskType,

    /// The title of the task
    title: []const u8,

    /// Timestamp when this task was last updated
    updated_at: i64,

    /// Version number for optimistic locking
    version: i32,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .created_at = "createdAt",
        .description = "description",
        .execution_id = "executionId",
        .has_linked_tasks = "hasLinkedTasks",
        .metadata = "metadata",
        .primary_task_id = "primaryTaskId",
        .priority = "priority",
        .reference = "reference",
        .status = "status",
        .status_reason = "statusReason",
        .support_metadata = "supportMetadata",
        .task_id = "taskId",
        .task_type = "taskType",
        .title = "title",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
