/// Edge Manager agent version.
pub const AgentVersion = struct {
    /// The number of Edge Manager agents.
    agent_count: i64,

    /// Version of the agent.
    version: []const u8,

    pub const json_field_names = .{
        .agent_count = "AgentCount",
        .version = "Version",
    };
};
