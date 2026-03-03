const ManagedAgentName = @import("managed_agent_name.zig").ManagedAgentName;

/// An object representing a change in state for a managed agent.
pub const ManagedAgentStateChange = struct {
    /// The name of the container that's associated with the managed agent.
    container_name: []const u8,

    /// The name of the managed agent.
    managed_agent_name: ManagedAgentName,

    /// The reason for the status of the managed agent.
    reason: ?[]const u8 = null,

    /// The status of the managed agent.
    status: []const u8,

    pub const json_field_names = .{
        .container_name = "containerName",
        .managed_agent_name = "managedAgentName",
        .reason = "reason",
        .status = "status",
    };
};
