const ActionGroupInvocationInput = @import("action_group_invocation_input.zig").ActionGroupInvocationInput;
const AgentCollaboratorInvocationInput = @import("agent_collaborator_invocation_input.zig").AgentCollaboratorInvocationInput;
const CodeInterpreterInvocationInput = @import("code_interpreter_invocation_input.zig").CodeInterpreterInvocationInput;
const InvocationType = @import("invocation_type.zig").InvocationType;
const KnowledgeBaseLookupInput = @import("knowledge_base_lookup_input.zig").KnowledgeBaseLookupInput;

/// Contains information pertaining to the action group or knowledge base that
/// is being invoked.
pub const InvocationInput = struct {
    /// Contains information about the action group to be invoked.
    action_group_invocation_input: ?ActionGroupInvocationInput = null,

    /// The collaborator's invocation input.
    agent_collaborator_invocation_input: ?AgentCollaboratorInvocationInput = null,

    /// Contains information about the code interpreter to be invoked.
    code_interpreter_invocation_input: ?CodeInterpreterInvocationInput = null,

    /// Specifies whether the agent is invoking an action group or a knowledge base.
    invocation_type: ?InvocationType = null,

    /// Contains details about the knowledge base to look up and the query to be
    /// made.
    knowledge_base_lookup_input: ?KnowledgeBaseLookupInput = null,

    /// The unique identifier of the trace.
    trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_group_invocation_input = "actionGroupInvocationInput",
        .agent_collaborator_invocation_input = "agentCollaboratorInvocationInput",
        .code_interpreter_invocation_input = "codeInterpreterInvocationInput",
        .invocation_type = "invocationType",
        .knowledge_base_lookup_input = "knowledgeBaseLookupInput",
        .trace_id = "traceId",
    };
};
