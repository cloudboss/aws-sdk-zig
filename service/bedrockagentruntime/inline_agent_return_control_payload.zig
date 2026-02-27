const InvocationInputMember = @import("invocation_input_member.zig").InvocationInputMember;

/// Contains information to return from the action group that the agent has
/// predicted to invoke.
///
/// This data type is used in the [InvokeAgent
/// response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax) API operation.
pub const InlineAgentReturnControlPayload = struct {
    /// The identifier of the action group invocation.
    invocation_id: ?[]const u8,

    /// A list of objects that contain information about the parameters and inputs
    /// that need to be sent into the API operation or function, based on what the
    /// agent determines from its session with the user.
    invocation_inputs: ?[]const InvocationInputMember,

    pub const json_field_names = .{
        .invocation_id = "invocationId",
        .invocation_inputs = "invocationInputs",
    };
};
