const AgentAliasRoutingConfigurationListItem = @import("agent_alias_routing_configuration_list_item.zig").AgentAliasRoutingConfigurationListItem;

/// Contains details about the history of the alias.
pub const AgentAliasHistoryEvent = struct {
    /// The date that the alias stopped being associated to the version in the
    /// `routingConfiguration` object
    end_date: ?i64 = null,

    /// Contains details about the version of the agent with which the alias is
    /// associated.
    routing_configuration: ?[]const AgentAliasRoutingConfigurationListItem = null,

    /// The date that the alias began being associated to the version in the
    /// `routingConfiguration` object.
    start_date: ?i64 = null,

    pub const json_field_names = .{
        .end_date = "endDate",
        .routing_configuration = "routingConfiguration",
        .start_date = "startDate",
    };
};
