const ActionInvocationType = @import("action_invocation_type.zig").ActionInvocationType;
const FunctionParameter = @import("function_parameter.zig").FunctionParameter;

/// Contains information about the function that the agent predicts should be
/// called.
///
/// This data type is used in the following API operations:
///
/// * In the `returnControl` field of the [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax)
pub const FunctionInvocationInput = struct {
    /// The action group that the function belongs to.
    action_group: []const u8,

    /// Contains information about the function to invoke,
    action_invocation_type: ?ActionInvocationType = null,

    /// The agent's ID.
    agent_id: ?[]const u8 = null,

    /// The collaborator's name.
    collaborator_name: ?[]const u8 = null,

    /// The name of the function.
    function: ?[]const u8 = null,

    /// A list of parameters of the function.
    parameters: ?[]const FunctionParameter = null,

    pub const json_field_names = .{
        .action_group = "actionGroup",
        .action_invocation_type = "actionInvocationType",
        .agent_id = "agentId",
        .collaborator_name = "collaboratorName",
        .function = "function",
        .parameters = "parameters",
    };
};
