const TaskExecutionStatus = @import("task_execution_status.zig").TaskExecutionStatus;
const LogLocation = @import("log_location.zig").LogLocation;

/// Represents an individual task within a threat model job.
pub const ThreatModelJobTask = struct {
    /// The unique identifier of the agent space.
    agent_space_id: ?[]const u8 = null,

    /// The date and time the task was created, in UTC format.
    created_at: ?i64 = null,

    /// A description of the task.
    description: ?[]const u8 = null,

    /// The current execution status of the task.
    execution_status: ?TaskExecutionStatus = null,

    /// The location of the task execution logs.
    logs_location: ?LogLocation = null,

    /// The unique identifier of the task.
    task_id: []const u8,

    /// The unique identifier of the threat model associated with the task.
    threat_model_id: ?[]const u8 = null,

    /// The unique identifier of the threat model job that contains the task.
    threat_model_job_id: ?[]const u8 = null,

    /// The title of the task.
    title: ?[]const u8 = null,

    /// The date and time the task was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .created_at = "createdAt",
        .description = "description",
        .execution_status = "executionStatus",
        .logs_location = "logsLocation",
        .task_id = "taskId",
        .threat_model_id = "threatModelId",
        .threat_model_job_id = "threatModelJobId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
