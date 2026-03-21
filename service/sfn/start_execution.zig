const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const StartExecutionInput = struct {
    /// The string that contains the JSON input data for the execution, for example:
    ///
    /// `"{\"first_name\" : \"Alejandro\"}"`
    ///
    /// If you don't include any JSON input data, you still must include the two
    /// braces, for
    /// example: `"{}"`
    ///
    /// Length constraints apply to the payload size, and are expressed as bytes in
    /// UTF-8 encoding.
    input: ?[]const u8 = null,

    /// Optional name of the execution. This name must be unique for your Amazon Web
    /// Services account, Region, and state machine for 90 days. For more
    /// information,
    /// see [
    /// Limits Related to State Machine
    /// Executions](https://docs.aws.amazon.com/step-functions/latest/dg/limits.html#service-limits-state-machine-executions) in the *Step Functions Developer Guide*.
    ///
    /// If you don't provide a name for the execution, Step Functions automatically
    /// generates a universally unique identifier (UUID) as the execution name.
    ///
    /// A name must *not* contain:
    ///
    /// * white space
    ///
    /// * brackets ` { } [ ]`
    ///
    /// * wildcard characters `? *`
    ///
    /// * special characters `" # % \ ^ | ~ ` $ & , ; : /`
    ///
    /// * control characters (`U+0000-001F`, `U+007F-009F`, `U+FFFE-FFFF`)
    ///
    /// * surrogates (`U+D800-DFFF`)
    ///
    /// * invalid characters (` U+10FFFF`)
    ///
    /// To enable logging with CloudWatch Logs, the name should only contain 0-9,
    /// A-Z, a-z, - and _.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the state machine to execute.
    ///
    /// The `stateMachineArn` parameter accepts one of the following inputs:
    ///
    /// * **An unqualified state machine ARN** – Refers to a state machine ARN that
    ///   isn't qualified with a version or alias ARN. The following is an example
    ///   of an unqualified state machine ARN.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// Step Functions doesn't associate state machine executions that you start
    /// with an unqualified ARN with a version. This is true even if that version
    /// uses the same revision that the execution used.
    ///
    /// * **A state machine version ARN** – Refers to a version ARN, which is a
    ///   combination of state machine ARN and the version number separated by a
    ///   colon (:). The following is an example of the ARN for version 10.
    ///
    /// `arn::states:::stateMachine::10`
    ///
    /// Step Functions doesn't associate executions that you start with a version
    /// ARN with any aliases that point to that version.
    ///
    /// * **A state machine alias ARN** – Refers to an alias ARN, which is a
    ///   combination of state machine ARN and the alias name separated by a colon
    ///   (:). The following is an example of the ARN for an alias named `PROD`.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// Step Functions associates executions
    /// that you start with an alias ARN with that alias and the state machine
    /// version used for
    /// that execution.
    state_machine_arn: []const u8,

    /// Passes the X-Ray trace header. The trace header can also be passed in the
    /// request
    /// payload.
    ///
    /// For X-Ray traces, all Amazon Web Services services use the `X-Amzn-Trace-Id`
    /// header from the HTTP request. Using the header is the preferred mechanism to
    /// identify a trace. `StartExecution` and `StartSyncExecution` API operations
    /// can also use `traceHeader` from the body of the request payload. If **both**
    /// sources are provided, Step Functions will use the **header value**
    /// (preferred) over the value in the request body.
    trace_header: ?[]const u8 = null,

    pub const json_field_names = .{
        .input = "input",
        .name = "name",
        .state_machine_arn = "stateMachineArn",
        .trace_header = "traceHeader",
    };
};

pub const StartExecutionOutput = struct {
    /// The Amazon Resource Name (ARN) that identifies the execution.
    execution_arn: []const u8,

    /// The date the execution is started.
    start_date: i64,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .start_date = "startDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartExecutionInput, options: CallOptions) !StartExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "states");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: StartExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.StartExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartExecutionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartExecutionOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
