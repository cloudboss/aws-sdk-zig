const aws = @import("aws");

const ConfirmationState = @import("confirmation_state.zig").ConfirmationState;
const ContentBody = @import("content_body.zig").ContentBody;
const ResponseState = @import("response_state.zig").ResponseState;

/// Contains information about the function that was called from the action
/// group and the response that was returned.
///
/// This data type is used in the following API operations:
///
/// * In the `returnControlInvocationResults` of the [InvokeAgent
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_RequestSyntax)
pub const FunctionResult = struct {
    /// The action group that the function belongs to.
    action_group: []const u8,

    /// The agent's ID.
    agent_id: ?[]const u8 = null,

    /// Contains the user confirmation information about the function that was
    /// called.
    confirmation_state: ?ConfirmationState = null,

    /// The name of the function that was called.
    function: ?[]const u8 = null,

    /// The response from the function call using the parameters. The response might
    /// be returned directly or from the Lambda function. Specify `TEXT` or
    /// `IMAGES`. The key of the object is the content type. You can only specify
    /// one type. If you specify `IMAGES`, you can specify only one image. You can
    /// specify images only when the function in the
    /// `returnControlInvocationResults` is a computer use action. For more
    /// information, see [Configure an Amazon Bedrock Agent to complete tasks with
    /// computer use
    /// tools](https://docs.aws.amazon.com/bedrock/latest/userguide/agent-computer-use.html).
    response_body: ?[]const aws.map.MapEntry(ContentBody) = null,

    /// Controls the final response state returned to end user when API/Function
    /// execution failed. When this state is FAILURE, the request would fail with
    /// dependency failure exception. When this state is REPROMPT, the API/function
    /// response will be sent to model for re-prompt
    response_state: ?ResponseState = null,

    pub const json_field_names = .{
        .action_group = "actionGroup",
        .agent_id = "agentId",
        .confirmation_state = "confirmationState",
        .function = "function",
        .response_body = "responseBody",
        .response_state = "responseState",
    };
};
