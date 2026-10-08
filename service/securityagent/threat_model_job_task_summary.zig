const TaskExecutionStatus = @import("task_execution_status.zig").TaskExecutionStatus;

/// Contains summary information about a threat model job task.
pub const ThreatModelJobTaskSummary = struct {
    /// The unique identifier of the agent space.
    agent_space_id: ?[]const u8 = null,

    /// The date and time the task was created, in UTC format.
    created_at: ?i64 = null,

    /// The current execution status of the task.
    execution_status: ?TaskExecutionStatus = null,

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
        .execution_status = "executionStatus",
        .task_id = "taskId",
        .threat_model_id = "threatModelId",
        .threat_model_job_id = "threatModelJobId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
