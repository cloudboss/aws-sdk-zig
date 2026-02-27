const AgentAliasHistoryEvent = @import("agent_alias_history_event.zig").AgentAliasHistoryEvent;
const AgentAliasStatus = @import("agent_alias_status.zig").AgentAliasStatus;
const AliasInvocationState = @import("alias_invocation_state.zig").AliasInvocationState;
const AgentAliasRoutingConfigurationListItem = @import("agent_alias_routing_configuration_list_item.zig").AgentAliasRoutingConfigurationListItem;

/// Contains details about an alias of an agent.
pub const AgentAlias = struct {
    /// The Amazon Resource Name (ARN) of the alias of the agent.
    agent_alias_arn: []const u8,

    /// Contains details about the history of the alias.
    agent_alias_history_events: ?[]const AgentAliasHistoryEvent,

    /// The unique identifier of the alias of the agent.
    agent_alias_id: []const u8,

    /// The name of the alias of the agent.
    agent_alias_name: []const u8,

    /// The status of the alias of the agent and whether it is ready for use. The
    /// following statuses are possible:
    ///
    /// * CREATING – The agent alias is being created.
    /// * PREPARED – The agent alias is finished being created or updated and is
    ///   ready to be invoked.
    /// * FAILED – The agent alias API operation failed.
    /// * UPDATING – The agent alias is being updated.
    /// * DELETING – The agent alias is being deleted.
    /// * DISSOCIATED - The agent alias has no version associated with it.
    agent_alias_status: AgentAliasStatus,

    /// The unique identifier of the agent.
    agent_id: []const u8,

    /// The invocation state for the agent alias. If the agent alias is running, the
    /// value is `ACCEPT_INVOCATIONS`. If the agent alias is paused, the value is
    /// `REJECT_INVOCATIONS`. Use the `UpdateAgentAlias` operation to change the
    /// invocation state.
    alias_invocation_state: ?AliasInvocationState,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8,

    /// The time at which the alias of the agent was created.
    created_at: i64,

    /// The description of the alias of the agent.
    description: ?[]const u8,

    /// Information on the failure of Provisioned Throughput assigned to an agent
    /// alias.
    failure_reasons: ?[]const []const u8,

    /// Contains details about the routing configuration of the alias.
    routing_configuration: []const AgentAliasRoutingConfigurationListItem,

    /// The time at which the alias was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .agent_alias_arn = "agentAliasArn",
        .agent_alias_history_events = "agentAliasHistoryEvents",
        .agent_alias_id = "agentAliasId",
        .agent_alias_name = "agentAliasName",
        .agent_alias_status = "agentAliasStatus",
        .agent_id = "agentId",
        .alias_invocation_state = "aliasInvocationState",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .failure_reasons = "failureReasons",
        .routing_configuration = "routingConfiguration",
        .updated_at = "updatedAt",
    };
};
