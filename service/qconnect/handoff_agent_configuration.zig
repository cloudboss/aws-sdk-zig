const AgentTarget = @import("agent_target.zig").AgentTarget;
const MultiAgentInstruction = @import("multi_agent_instruction.zig").MultiAgentInstruction;

/// A collaborator agent configuration in which the Orchestration AI Agent
/// transfers control of the conversation to the collaborator agent.
pub const HandoffAgentConfiguration = struct {
    /// The collaborator agent to hand off to.
    agent_target: AgentTarget,

    /// Specifies whether the caller's audio is streamed directly to the
    /// collaborator agent and the collaborator's audio response is played back
    /// during the handoff. This applies only to voice handoffs.
    audio_streaming_enabled: ?bool = null,

    /// Specifies whether the conversation is handed off to this collaborator agent
    /// immediately on the first turn, without any orchestration reasoning. At most
    /// one handoff in an AI Agent's configuration can set this to `true`.
    immediate_handoff: ?bool = null,

    /// The instruction that tells the Orchestration AI Agent when and how to hand
    /// off to this collaborator agent.
    instruction: ?MultiAgentInstruction = null,

    pub const json_field_names = .{
        .agent_target = "agentTarget",
        .audio_streaming_enabled = "audioStreamingEnabled",
        .immediate_handoff = "immediateHandoff",
        .instruction = "instruction",
    };
};
