const AgentTurnSpecification = @import("agent_turn_specification.zig").AgentTurnSpecification;
const UserTurnSpecification = @import("user_turn_specification.zig").UserTurnSpecification;

/// Contains information about the messages in the turn.
pub const TurnSpecification = struct {
    /// Contains information about the agent messages in the turn.
    agent_turn: ?AgentTurnSpecification,

    /// Contains information about the user messages in the turn.
    user_turn: ?UserTurnSpecification,

    pub const json_field_names = .{
        .agent_turn = "agentTurn",
        .user_turn = "userTurn",
    };
};
