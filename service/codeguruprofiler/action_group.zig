pub const ActionGroup = enum {
    /// Permission group type for Agent APIs - ConfigureAgent, PostAgentProfile
    agent_permissions,

    pub const json_field_names = .{
        .agent_permissions = "AGENT_PERMISSIONS",
    };
};
