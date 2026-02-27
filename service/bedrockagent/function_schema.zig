const Function = @import("function.zig").Function;

/// Defines functions that each define parameters that the agent needs to invoke
/// from the user. Each function represents an action in an action group.
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
pub const FunctionSchema = union(enum) {
    /// A list of functions that each define an action in the action group.
    functions: ?[]const Function,

    pub const json_field_names = .{
        .functions = "functions",
    };
};
