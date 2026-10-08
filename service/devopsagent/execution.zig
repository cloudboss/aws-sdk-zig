const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// Represents an execution instance with its lifecycle information
pub const Execution = struct {
    /// The unique identifier for the agent space containing this execution
    agent_space_id: []const u8,

    /// The specific subtask being executed by the agent
    agent_sub_task: []const u8,

    /// The type of agent that performed this execution.
    agent_type: ?[]const u8 = null,

    /// Timestamp when this execution was created
    created_at: i64,

    /// The unique identifier for this execution
    execution_id: []const u8,

    /// The current status of this execution
    execution_status: ExecutionStatus,

    /// The identifier of the parent execution, if this is a child execution
    parent_execution_id: ?[]const u8 = null,

    /// The unique identifier for the user session associated with this execution
    uid: ?[]const u8 = null,

    /// Timestamp when this execution was last updated
    updated_at: i64,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .agent_sub_task = "agentSubTask",
        .agent_type = "agentType",
        .created_at = "createdAt",
        .execution_id = "executionId",
        .execution_status = "executionStatus",
        .parent_execution_id = "parentExecutionId",
        .uid = "uid",
        .updated_at = "updatedAt",
    };
};
