const ApiResult = @import("api_result.zig").ApiResult;
const FunctionResult = @import("function_result.zig").FunctionResult;

/// A result from the invocation of an action. For more information, see [Return
/// control to the agent
/// developer](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-returncontrol.html) and [Control session context](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-session-state.html).
///
/// This data type is used in the following API operations:
///
/// * [InvokeAgent
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_RequestSyntax)
pub const InvocationResultMember = union(enum) {
    /// The result from the API response from the action group invocation.
    api_result: ?ApiResult,
    /// The result from the function from the action group invocation.
    function_result: ?FunctionResult,

    pub const json_field_names = .{
        .api_result = "apiResult",
        .function_result = "functionResult",
    };
};
