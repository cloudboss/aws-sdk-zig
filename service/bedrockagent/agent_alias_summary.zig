const AgentAliasStatus = @import("agent_alias_status.zig").AgentAliasStatus;
const AliasInvocationState = @import("alias_invocation_state.zig").AliasInvocationState;
const AgentAliasRoutingConfigurationListItem = @import("agent_alias_routing_configuration_list_item.zig").AgentAliasRoutingConfigurationListItem;

/// Contains details about an alias of an agent.
pub const AgentAliasSummary = struct {
    /// Contains details about
    agent_alias_id: []const u8,

    /// The name of the alias.
    agent_alias_name: []const u8,

    /// The status of the alias.
    agent_alias_status: AgentAliasStatus,

    /// The invocation state for the agent alias. If the agent alias is running, the
    /// value is `ACCEPT_INVOCATIONS`. If the agent alias is paused, the value is
    /// `REJECT_INVOCATIONS`. Use the `UpdateAgentAlias` operation to change the
    /// invocation state.
    alias_invocation_state: ?AliasInvocationState,

    /// The time at which the alias of the agent was created.
    created_at: i64,

    /// The description of the alias.
    description: ?[]const u8,

    /// Contains details about the version of the agent with which the alias is
    /// associated.
    routing_configuration: ?[]const AgentAliasRoutingConfigurationListItem,

    /// The time at which the alias was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_alias_id = "agentAliasId",
        .agent_alias_name = "agentAliasName",
        .agent_alias_status = "agentAliasStatus",
        .alias_invocation_state = "aliasInvocationState",
        .created_at = "createdAt",
        .description = "description",
        .routing_configuration = "routingConfiguration",
        .updated_at = "updatedAt",
    };
};
