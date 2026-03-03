/// Can be used to define a list of preferred agents to target the contact to
/// within the queue. Note that agents
/// must have the queue in their routing profile in order to be offered the
/// contact.
pub const AgentsCriteria = struct {
    /// An object to specify a list of agents, by user ID.
    agent_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .agent_ids = "AgentIds",
    };
};
