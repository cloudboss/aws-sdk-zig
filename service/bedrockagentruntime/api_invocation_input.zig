const ActionInvocationType = @import("action_invocation_type.zig").ActionInvocationType;
const ApiParameter = @import("api_parameter.zig").ApiParameter;
const ApiRequestBody = @import("api_request_body.zig").ApiRequestBody;

/// Contains information about the API operation that the agent predicts should
/// be called.
///
/// This data type is used in the following API operations:
///
/// * In the `returnControl` field of the [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax)
pub const ApiInvocationInput = struct {
    /// The action group that the API operation belongs to.
    action_group: []const u8,

    /// Contains information about the API operation to invoke.
    action_invocation_type: ?ActionInvocationType = null,

    /// The agent's ID.
    agent_id: ?[]const u8 = null,

    /// The path to the API operation.
    api_path: ?[]const u8 = null,

    /// The agent collaborator's name.
    collaborator_name: ?[]const u8 = null,

    /// The HTTP method of the API operation.
    http_method: ?[]const u8 = null,

    /// The parameters to provide for the API request, as the agent elicited from
    /// the user.
    parameters: ?[]const ApiParameter = null,

    /// The request body to provide for the API request, as the agent elicited from
    /// the user.
    request_body: ?ApiRequestBody = null,

    pub const json_field_names = .{
        .action_group = "actionGroup",
        .action_invocation_type = "actionInvocationType",
        .agent_id = "agentId",
        .api_path = "apiPath",
        .collaborator_name = "collaboratorName",
        .http_method = "httpMethod",
        .parameters = "parameters",
        .request_body = "requestBody",
    };
};
