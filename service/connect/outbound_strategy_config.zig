const AgentFirst = @import("agent_first.zig").AgentFirst;

/// The config of the outbound strategy.
pub const OutboundStrategyConfig = struct {
    /// The config of agent first outbound strategy.
    agent_first: ?AgentFirst,

    pub const json_field_names = .{
        .agent_first = "AgentFirst",
    };
};
