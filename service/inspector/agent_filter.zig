const AgentHealthCode = @import("agent_health_code.zig").AgentHealthCode;
const AgentHealth = @import("agent_health.zig").AgentHealth;

/// Contains information about an Amazon Inspector agent. This data type is used
/// as a
/// request parameter in the ListAssessmentRunAgents action.
pub const AgentFilter = struct {
    /// The detailed health state of the agent. Values can be set to **IDLE**,
    /// **RUNNING**, **SHUTDOWN**, **UNHEALTHY**, **THROTTLED**, and **UNKNOWN**.
    agent_health_codes: []const AgentHealthCode,

    /// The current health state of the agent. Values can be set to **HEALTHY** or
    /// **UNHEALTHY**.
    agent_healths: []const AgentHealth,

    pub const json_field_names = .{
        .agent_health_codes = "agentHealthCodes",
        .agent_healths = "agentHealths",
    };
};
