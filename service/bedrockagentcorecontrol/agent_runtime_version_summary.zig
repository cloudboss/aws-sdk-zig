const AgentRuntimeStatus = @import("agent_runtime_status.zig").AgentRuntimeStatus;

/// Summary information about an agent runtime version associated with a
/// capacity provider. This is returned by
/// `ListAgentRuntimeVersionsByCapacityProvider`.
pub const AgentRuntimeVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the agent runtime.
    agent_runtime_arn: []const u8,

    /// The version of the agent runtime.
    agent_runtime_version: []const u8,

    /// The current status of the agent runtime version.
    status: AgentRuntimeStatus,

    pub const json_field_names = .{
        .agent_runtime_arn = "agentRuntimeArn",
        .agent_runtime_version = "agentRuntimeVersion",
        .status = "status",
    };
};
