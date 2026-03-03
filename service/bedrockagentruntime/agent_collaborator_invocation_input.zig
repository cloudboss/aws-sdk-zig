const AgentCollaboratorInputPayload = @import("agent_collaborator_input_payload.zig").AgentCollaboratorInputPayload;

/// An agent collaborator invocation input.
pub const AgentCollaboratorInvocationInput = struct {
    /// The collaborator's alias ARN.
    agent_collaborator_alias_arn: ?[]const u8 = null,

    /// The collaborator's name.
    agent_collaborator_name: ?[]const u8 = null,

    /// Text or action invocation result input for the collaborator.
    input: ?AgentCollaboratorInputPayload = null,

    pub const json_field_names = .{
        .agent_collaborator_alias_arn = "agentCollaboratorAliasArn",
        .agent_collaborator_name = "agentCollaboratorName",
        .input = "input",
    };
};
