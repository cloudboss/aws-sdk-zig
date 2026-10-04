const DelegateAgentConfiguration = @import("delegate_agent_configuration.zig").DelegateAgentConfiguration;
const HandoffAgentConfiguration = @import("handoff_agent_configuration.zig").HandoffAgentConfiguration;

/// A union that configures a single collaborator agent for an Orchestration AI
/// Agent, as either a delegate or a handoff.
pub const MultiAgentConfiguration = union(enum) {
    /// Configures the collaborator agent as a delegate that the Orchestration AI
    /// Agent invokes while retaining control of the conversation.
    delegate_agent_configuration: ?DelegateAgentConfiguration,
    /// Configures the collaborator agent as a handoff target that the Orchestration
    /// AI Agent transfers control of the conversation to.
    handoff_agent_configuration: ?HandoffAgentConfiguration,

    pub const json_field_names = .{
        .delegate_agent_configuration = "delegateAgentConfiguration",
        .handoff_agent_configuration = "handoffAgentConfiguration",
    };
};
