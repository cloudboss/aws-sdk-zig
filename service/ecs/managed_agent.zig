const ManagedAgentName = @import("managed_agent_name.zig").ManagedAgentName;

/// Details about the managed agent status for the container.
pub const ManagedAgent = struct {
    /// The Unix timestamp for the time when the managed agent was last started.
    last_started_at: ?i64,

    /// The last known status of the managed agent.
    last_status: ?[]const u8,

    /// The name of the managed agent. When the execute command feature is turned
    /// on, the
    /// managed agent name is `ExecuteCommandAgent`.
    name: ?ManagedAgentName,

    /// The reason for why the managed agent is in the state it is in.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .last_started_at = "lastStartedAt",
        .last_status = "lastStatus",
        .name = "name",
        .reason = "reason",
    };
};
