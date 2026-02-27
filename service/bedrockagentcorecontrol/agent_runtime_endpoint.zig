const AgentRuntimeEndpointStatus = @import("agent_runtime_endpoint_status.zig").AgentRuntimeEndpointStatus;

/// Contains information about an agent runtime endpoint. An endpoint provides a
/// way to connect to and interact with an agent runtime.
pub const AgentRuntimeEndpoint = struct {
    /// The Amazon Resource Name (ARN) of the agent runtime associated with the
    /// endpoint.
    agent_runtime_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the agent runtime endpoint.
    agent_runtime_endpoint_arn: []const u8,

    /// The timestamp when the agent runtime endpoint was created.
    created_at: i64,

    /// The description of the agent runtime endpoint.
    description: ?[]const u8,

    /// The unique identifier of the agent runtime endpoint.
    id: []const u8,

    /// The timestamp when the agent runtime endpoint was last updated.
    last_updated_at: i64,

    /// The live version of the agent runtime endpoint. This is the version that is
    /// currently serving requests.
    live_version: ?[]const u8,

    /// The name of the agent runtime endpoint.
    name: []const u8,

    /// The current status of the agent runtime endpoint.
    status: AgentRuntimeEndpointStatus,

    /// The target version of the agent runtime endpoint. This is the version that
    /// the endpoint is being updated to.
    target_version: ?[]const u8,

    pub const json_field_names = .{
        .agent_runtime_arn = "agentRuntimeArn",
        .agent_runtime_endpoint_arn = "agentRuntimeEndpointArn",
        .created_at = "createdAt",
        .description = "description",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .live_version = "liveVersion",
        .name = "name",
        .status = "status",
        .target_version = "targetVersion",
    };
};
