/// Inventory data for installed discovery agents.
pub const CustomerAgentInfo = struct {
    /// Number of active discovery agents.
    active_agents: i32 = 0,

    /// Number of blacklisted discovery agents.
    black_listed_agents: i32 = 0,

    /// Number of healthy discovery agents
    healthy_agents: i32 = 0,

    /// Number of discovery agents with status SHUTDOWN.
    shutdown_agents: i32 = 0,

    /// Total number of discovery agents.
    total_agents: i32 = 0,

    /// Number of unhealthy discovery agents.
    unhealthy_agents: i32 = 0,

    /// Number of unknown discovery agents.
    unknown_agents: i32 = 0,

    pub const json_field_names = .{
        .active_agents = "activeAgents",
        .black_listed_agents = "blackListedAgents",
        .healthy_agents = "healthyAgents",
        .shutdown_agents = "shutdownAgents",
        .total_agents = "totalAgents",
        .unhealthy_agents = "unhealthyAgents",
        .unknown_agents = "unknownAgents",
    };
};
