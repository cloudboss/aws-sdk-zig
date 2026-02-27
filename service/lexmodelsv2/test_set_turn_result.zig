const AgentTurnResult = @import("agent_turn_result.zig").AgentTurnResult;
const UserTurnResult = @import("user_turn_result.zig").UserTurnResult;

/// Contains information about the results of the analysis of a turn in the test
/// set.
pub const TestSetTurnResult = struct {
    /// Contains information about the agent messages in the turn.
    agent: ?AgentTurnResult,

    /// Contains information about the user messages in the turn.
    user: ?UserTurnResult,

    pub const json_field_names = .{
        .agent = "agent",
        .user = "user",
    };
};
