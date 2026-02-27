const ApiInvocationInput = @import("api_invocation_input.zig").ApiInvocationInput;
const FunctionInvocationInput = @import("function_invocation_input.zig").FunctionInvocationInput;

/// Contains details about the API operation or function that the agent predicts
/// should be called.
///
/// This data type is used in the following API operations:
///
/// * In the `returnControl` field of the [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax)
pub const InvocationInputMember = union(enum) {
    /// Contains information about the API operation that the agent predicts should
    /// be called.
    api_invocation_input: ?ApiInvocationInput,
    /// Contains information about the function that the agent predicts should be
    /// called.
    function_invocation_input: ?FunctionInvocationInput,

    pub const json_field_names = .{
        .api_invocation_input = "apiInvocationInput",
        .function_invocation_input = "functionInvocationInput",
    };
};
