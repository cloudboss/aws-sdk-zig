const Metadata = @import("metadata.zig").Metadata;
const AgentCollaboratorOutputPayload = @import("agent_collaborator_output_payload.zig").AgentCollaboratorOutputPayload;

/// Output from an agent collaborator.
pub const AgentCollaboratorInvocationOutput = struct {
    /// The output's agent collaborator alias ARN.
    agent_collaborator_alias_arn: ?[]const u8,

    /// The output's agent collaborator name.
    agent_collaborator_name: ?[]const u8,

    /// Contains information about the output from the agent collaborator.
    metadata: ?Metadata,

    /// The output's output.
    output: ?AgentCollaboratorOutputPayload,

    pub const json_field_names = .{
        .agent_collaborator_alias_arn = "agentCollaboratorAliasArn",
        .agent_collaborator_name = "agentCollaboratorName",
        .metadata = "metadata",
        .output = "output",
    };
};
