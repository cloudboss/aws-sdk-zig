const AgentTarget = @import("agent_target.zig").AgentTarget;
const MultiAgentInstruction = @import("multi_agent_instruction.zig").MultiAgentInstruction;

/// A collaborator agent configuration in which the Orchestration AI Agent
/// invokes the collaborator, resuming when the collaborator returns.
pub const DelegateAgentConfiguration = struct {
    /// The collaborator agent to delegate to.
    agent_target: AgentTarget,

    /// The instruction that tells the Orchestration AI Agent when and how to
    /// delegate to this collaborator agent.
    instruction: ?MultiAgentInstruction = null,

    pub const json_field_names = .{
        .agent_target = "agentTarget",
        .instruction = "instruction",
    };
};
