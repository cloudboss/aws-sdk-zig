const ActionGroupInvocationOutput = @import("action_group_invocation_output.zig").ActionGroupInvocationOutput;
const AgentCollaboratorInvocationOutput = @import("agent_collaborator_invocation_output.zig").AgentCollaboratorInvocationOutput;
const CodeInterpreterInvocationOutput = @import("code_interpreter_invocation_output.zig").CodeInterpreterInvocationOutput;
const FinalResponse = @import("final_response.zig").FinalResponse;
const KnowledgeBaseLookupOutput = @import("knowledge_base_lookup_output.zig").KnowledgeBaseLookupOutput;
const RepromptResponse = @import("reprompt_response.zig").RepromptResponse;
const Type = @import("type.zig").Type;

/// Contains the result or output of an action group or knowledge base, or the
/// response to the user.
pub const Observation = struct {
    /// Contains the JSON-formatted string returned by the API invoked by the action
    /// group.
    action_group_invocation_output: ?ActionGroupInvocationOutput = null,

    /// A collaborator's invocation output.
    agent_collaborator_invocation_output: ?AgentCollaboratorInvocationOutput = null,

    /// Contains the JSON-formatted string returned by the API invoked by the code
    /// interpreter.
    code_interpreter_invocation_output: ?CodeInterpreterInvocationOutput = null,

    /// Contains details about the response to the user.
    final_response: ?FinalResponse = null,

    /// Contains details about the results from looking up the knowledge base.
    knowledge_base_lookup_output: ?KnowledgeBaseLookupOutput = null,

    /// Contains details about the response to reprompt the input.
    reprompt_response: ?RepromptResponse = null,

    /// The unique identifier of the trace.
    trace_id: ?[]const u8 = null,

    /// Specifies what kind of information the agent returns in the observation. The
    /// following values are possible.
    ///
    /// * `ACTION_GROUP` – The agent returns the result of an action group.
    /// * `KNOWLEDGE_BASE` – The agent returns information from a knowledge base.
    /// * `FINISH` – The agent returns a final response to the user with no
    ///   follow-up.
    /// * `ASK_USER` – The agent asks the user a question.
    /// * `REPROMPT` – The agent prompts the user again for the same information.
    @"type": ?Type = null,

    pub const json_field_names = .{
        .action_group_invocation_output = "actionGroupInvocationOutput",
        .agent_collaborator_invocation_output = "agentCollaboratorInvocationOutput",
        .code_interpreter_invocation_output = "codeInterpreterInvocationOutput",
        .final_response = "finalResponse",
        .knowledge_base_lookup_output = "knowledgeBaseLookupOutput",
        .reprompt_response = "repromptResponse",
        .trace_id = "traceId",
        .@"type" = "type",
    };
};
