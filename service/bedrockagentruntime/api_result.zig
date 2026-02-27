const aws = @import("aws");

const ConfirmationState = @import("confirmation_state.zig").ConfirmationState;
const ContentBody = @import("content_body.zig").ContentBody;
const ResponseState = @import("response_state.zig").ResponseState;

/// Contains information about the API operation that was called from the action
/// group and the response body that was returned.
///
/// This data type is used in the following API operations:
///
/// * In the `returnControlInvocationResults` of the [InvokeAgent
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_RequestSyntax)
pub const ApiResult = struct {
    /// The action group that the API operation belongs to.
    action_group: []const u8,

    /// The agent's ID.
    agent_id: ?[]const u8,

    /// The path to the API operation.
    api_path: ?[]const u8,

    /// Controls the API operations or functions to invoke based on the user
    /// confirmation.
    confirmation_state: ?ConfirmationState,

    /// The HTTP method for the API operation.
    http_method: ?[]const u8,

    /// http status code from API execution response (for example: 200, 400, 500).
    http_status_code: ?i32,

    /// The response body from the API operation. The key of the object is the
    /// content type (currently, only `TEXT` is supported). The response may be
    /// returned directly or from the Lambda function.
    response_body: ?[]const aws.map.MapEntry(ContentBody),

    /// Controls the final response state returned to end user when API/Function
    /// execution failed. When this state is FAILURE, the request would fail with
    /// dependency failure exception. When this state is REPROMPT, the API/function
    /// response will be sent to model for re-prompt
    response_state: ?ResponseState,

    pub const json_field_names = .{
        .action_group = "actionGroup",
        .agent_id = "agentId",
        .api_path = "apiPath",
        .confirmation_state = "confirmationState",
        .http_method = "httpMethod",
        .http_status_code = "httpStatusCode",
        .response_body = "responseBody",
        .response_state = "responseState",
    };
};
