const ExecutionType = @import("execution_type.zig").ExecutionType;
const Parameter = @import("parameter.zig").Parameter;
const RequestBody = @import("request_body.zig").RequestBody;

/// Contains information about the action group being invoked. For more
/// information about the possible structures, see the InvocationInput tab in
/// [OrchestrationTrace](https://docs.aws.amazon.com/bedrock/latest/userguide/trace-orchestration.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
pub const ActionGroupInvocationInput = struct {
    /// The name of the action group.
    action_group_name: ?[]const u8,

    /// The path to the API to call, based off the action group.
    api_path: ?[]const u8,

    /// How fulfillment of the action is handled. For more information, see
    /// [Handling fulfillment of the
    /// action](https://docs.aws.amazon.com/bedrock/latest/userguide/action-handle.html).
    execution_type: ?ExecutionType,

    /// The function in the action group to call.
    function: ?[]const u8,

    /// The unique identifier of the invocation. Only returned if the
    /// `executionType` is `RETURN_CONTROL`.
    invocation_id: ?[]const u8,

    /// The parameters in the Lambda input event.
    parameters: ?[]const Parameter,

    /// The parameters in the request body for the Lambda input event.
    request_body: ?RequestBody,

    /// The API method being used, based off the action group.
    verb: ?[]const u8,

    pub const json_field_names = .{
        .action_group_name = "actionGroupName",
        .api_path = "apiPath",
        .execution_type = "executionType",
        .function = "function",
        .invocation_id = "invocationId",
        .parameters = "parameters",
        .request_body = "requestBody",
        .verb = "verb",
    };
};
