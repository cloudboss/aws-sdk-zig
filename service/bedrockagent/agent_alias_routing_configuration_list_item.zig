/// Contains details about the routing configuration of the alias.
pub const AgentAliasRoutingConfigurationListItem = struct {
    /// The version of the agent with which the alias is associated.
    agent_version: ?[]const u8,

    /// Information on the Provisioned Throughput assigned to an agent alias.
    provisioned_throughput: ?[]const u8,

    pub const json_field_names = .{
        .agent_version = "agentVersion",
        .provisioned_throughput = "provisionedThroughput",
    };
};
