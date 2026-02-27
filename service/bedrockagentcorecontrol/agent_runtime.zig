const AgentRuntimeStatus = @import("agent_runtime_status.zig").AgentRuntimeStatus;

/// Contains information about an agent runtime. An agent runtime is the
/// execution environment for a Amazon Bedrock AgentCore Agent.
pub const AgentRuntime = struct {
    /// The Amazon Resource Name (ARN) of the agent runtime.
    agent_runtime_arn: []const u8,

    /// The unique identifier of the agent runtime.
    agent_runtime_id: []const u8,

    /// The name of the agent runtime.
    agent_runtime_name: []const u8,

    /// The version of the agent runtime.
    agent_runtime_version: []const u8,

    /// The description of the agent runtime.
    description: []const u8,

    /// The timestamp when the agent runtime was last updated.
    last_updated_at: i64,

    /// The current status of the agent runtime.
    status: AgentRuntimeStatus,

    pub const json_field_names = .{
        .agent_runtime_arn = "agentRuntimeArn",
        .agent_runtime_id = "agentRuntimeId",
        .agent_runtime_name = "agentRuntimeName",
        .agent_runtime_version = "agentRuntimeVersion",
        .description = "description",
        .last_updated_at = "lastUpdatedAt",
        .status = "status",
    };
};
