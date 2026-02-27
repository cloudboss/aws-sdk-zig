const Type = @import("type.zig").Type;

/// Contains details about a parameter in a function for an action group.
///
/// This data type is used in the following API operations:
///
/// * [CreateAgentActionGroup
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_CreateAgentActionGroup.html#API_agent_CreateAgentActionGroup_RequestSyntax)
/// * [CreateAgentActionGroup
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_CreateAgentActionGroup.html#API_agent_CreateAgentActionGroup_ResponseSyntax)
/// * [UpdateAgentActionGroup
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_UpdateAgentActionGroup.html#API_agent_UpdateAgentActionGroup_RequestSyntax)
/// * [UpdateAgentActionGroup
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_UpdateAgentActionGroup.html#API_agent_UpdateAgentActionGroup_ResponseSyntax)
/// * [GetAgentActionGroup
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_GetAgentActionGroup.html#API_agent_GetAgentActionGroup_ResponseSyntax)
pub const ParameterDetail = struct {
    /// A description of the parameter. Helps the foundation model determine how to
    /// elicit the parameters from the user.
    description: ?[]const u8,

    /// Whether the parameter is required for the agent to complete the function for
    /// action group invocation.
    required: ?bool,

    /// The data type of the parameter.
    type: Type,

    pub const json_field_names = .{
        .description = "description",
        .required = "required",
        .type = "type",
    };
};
