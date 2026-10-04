const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InspectionLevel = @import("inspection_level.zig").InspectionLevel;
const MockInput = @import("mock_input.zig").MockInput;
const TestStateConfiguration = @import("test_state_configuration.zig").TestStateConfiguration;
const InspectionData = @import("inspection_data.zig").InspectionData;
const TestExecutionStatus = @import("test_execution_status.zig").TestExecutionStatus;

pub const TestStateInput = struct {
    /// A JSON string representing a valid Context object for the state under test.
    /// This field may only be specified if a mock is specified in the same request.
    context: ?[]const u8 = null,

    /// The [Amazon States
    /// Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html) (ASL) definition of the state or state machine.
    definition: []const u8,

    /// A string that contains the JSON input data for the state.
    input: ?[]const u8 = null,

    /// Determines the values to return when a state is tested. You can specify one
    /// of the following types:
    ///
    /// * `INFO`: Shows the final state output. By default, Step Functions sets
    ///   `inspectionLevel` to `INFO` if you don't specify a level.
    ///
    /// * `DEBUG`: Shows the final state output along with the input and output data
    ///   processing result.
    ///
    /// * `TRACE`: Shows the HTTP request and response for an HTTP Task. This level
    ///   also shows the final state output along with the input and output data
    ///   processing result.
    ///
    /// Each of these levels also provide information about the status of the state
    /// execution and the next state to transition to.
    inspection_level: ?InspectionLevel = null,

    /// Defines a mocked result or error for the state under test.
    ///
    /// A mock can only be specified for Task, Map, or Parallel states. If it is
    /// specified for another state type, an exception will be thrown.
    mock: ?MockInput = null,

    /// Specifies whether or not to include secret information in the test result.
    /// For HTTP Tasks, a secret includes the data that an EventBridge connection
    /// adds to modify the HTTP request headers, query parameters, and body. Step
    /// Functions doesn't omit any information included in the state definition or
    /// the HTTP response.
    ///
    /// If you set `revealSecrets` to `true`, you must make sure that the IAM user
    /// that calls the `TestState` API has permission for the `states:RevealSecrets`
    /// action. For an example of IAM policy that sets the `states:RevealSecrets`
    /// permission, see [IAM permissions to test a
    /// state](https://docs.aws.amazon.com/step-functions/latest/dg/test-state-isolation.html#test-state-permissions). Without this permission, Step Functions throws an access denied error.
    ///
    /// By default, `revealSecrets` is set to `false`.
    reveal_secrets: ?bool = null,

    /// The Amazon Resource Name (ARN) of the execution role with the required IAM
    /// permissions for the state.
    role_arn: ?[]const u8 = null,

    /// Contains configurations for the state under test.
    state_configuration: ?TestStateConfiguration = null,

    /// Denotes the particular state within a state machine definition to be tested.
    /// If this field is specified, the `definition` must contain a fully-formed
    /// state machine definition.
    state_name: ?[]const u8 = null,

    /// JSON object literal that sets variables used in the state under test. Object
    /// keys are the variable names and values are the variable values.
    variables: ?[]const u8 = null,

    pub const json_field_names = .{
        .context = "context",
        .definition = "definition",
        .input = "input",
        .inspection_level = "inspectionLevel",
        .mock = "mock",
        .reveal_secrets = "revealSecrets",
        .role_arn = "roleArn",
        .state_configuration = "stateConfiguration",
        .state_name = "stateName",
        .variables = "variables",
    };
};

pub const TestStateOutput = struct {
    /// A detailed explanation of the cause for the error when the execution of a
    /// state fails.
    cause: ?[]const u8 = null,

    /// The error returned when the execution of a state fails.
    @"error": ?[]const u8 = null,

    /// Returns additional details about the state's execution, including its input
    /// and output data processing flow, and HTTP request and response information.
    /// The `inspectionLevel` request parameter specifies which details are
    /// returned.
    inspection_data: ?InspectionData = null,

    /// The name of the next state to transition to. If you haven't defined a next
    /// state in your definition or if the execution of the state fails, this field
    /// doesn't contain a value.
    next_state: ?[]const u8 = null,

    /// The JSON output data of the state. Length constraints apply to the payload
    /// size, and are expressed as bytes in UTF-8 encoding.
    output: ?[]const u8 = null,

    /// The execution status of the state.
    status: ?TestExecutionStatus = null,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
        .inspection_data = "inspectionData",
        .next_state = "nextState",
        .output = "output",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestStateInput, options: CallOptions) !TestStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "states", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: TestStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.TestState");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestStateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TestStateOutput, body, allocator);
}
