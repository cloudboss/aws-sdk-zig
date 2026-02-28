const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestStateInput, options: Options) !TestStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sfn");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: TestStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sfn", "SFN", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AWSStepFunctions.TestState");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !TestStateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TestStateOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ActivityAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .activity_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ActivityDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .activity_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ActivityLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .activity_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ActivityWorkerLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .activity_worker_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExecutionAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .execution_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExecutionDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .execution_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExecutionLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .execution_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExecutionNotRedrivable")) {
        return .{ .arena = arena, .kind = .{ .execution_not_redrivable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArn")) {
        return .{ .arena = arena, .kind = .{ .invalid_arn = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDefinition")) {
        return .{ .arena = arena, .kind = .{ .invalid_definition = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEncryptionConfiguration")) {
        return .{ .arena = arena, .kind = .{ .invalid_encryption_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExecutionInput")) {
        return .{ .arena = arena, .kind = .{ .invalid_execution_input = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLoggingConfiguration")) {
        return .{ .arena = arena, .kind = .{ .invalid_logging_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidName")) {
        return .{ .arena = arena, .kind = .{ .invalid_name = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOutput")) {
        return .{ .arena = arena, .kind = .{ .invalid_output = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTracingConfiguration")) {
        return .{ .arena = arena, .kind = .{ .invalid_tracing_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .kms_throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRequiredParameter")) {
        return .{ .arena = arena, .kind = .{ .missing_required_parameter = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StateMachineAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .state_machine_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StateMachineDeleting")) {
        return .{ .arena = arena, .kind = .{ .state_machine_deleting = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StateMachineDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .state_machine_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StateMachineLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .state_machine_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StateMachineTypeNotSupported")) {
        return .{ .arena = arena, .kind = .{ .state_machine_type_not_supported = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaskDoesNotExist")) {
        return .{ .arena = arena, .kind = .{ .task_does_not_exist = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaskTimedOut")) {
        return .{ .arena = arena, .kind = .{ .task_timed_out = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTags")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
