const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const IncludedData = @import("included_data.zig").IncludedData;
const BillingDetails = @import("billing_details.zig").BillingDetails;
const CloudWatchEventsExecutionDataDetails = @import("cloud_watch_events_execution_data_details.zig").CloudWatchEventsExecutionDataDetails;
const SyncExecutionStatus = @import("sync_execution_status.zig").SyncExecutionStatus;

pub const StartSyncExecutionInput = struct {
    /// If your state machine definition is encrypted with a KMS key, callers must
    /// have `kms:Decrypt` permission to decrypt the definition. Alternatively, you
    /// can call the API with `includedData = METADATA_ONLY` to get a successful
    /// response without the encrypted definition.
    included_data: ?IncludedData = null,

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

    /// The name of the execution.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the state machine to execute.
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
        .included_data = "includedData",
        .input = "input",
        .name = "name",
        .state_machine_arn = "stateMachineArn",
        .trace_header = "traceHeader",
    };
};

pub const StartSyncExecutionOutput = struct {
    /// An object that describes workflow billing details, including billed duration
    /// and memory
    /// use.
    billing_details: ?BillingDetails = null,

    /// A more detailed explanation of the cause of the failure.
    cause: ?[]const u8 = null,

    /// The error code of the failure.
    @"error": ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the execution.
    execution_arn: []const u8,

    /// The string that contains the JSON input data of the execution. Length
    /// constraints apply to the payload size, and are expressed as bytes in UTF-8
    /// encoding.
    input: ?[]const u8 = null,

    input_details: ?CloudWatchEventsExecutionDataDetails = null,

    /// The name of the execution.
    name: ?[]const u8 = null,

    /// The JSON output data of the execution. Length constraints apply to the
    /// payload size, and are expressed as bytes in UTF-8 encoding.
    ///
    /// This field is set only if the execution succeeds. If the execution fails,
    /// this field is
    /// null.
    output: ?[]const u8 = null,

    output_details: ?CloudWatchEventsExecutionDataDetails = null,

    /// The date the execution is started.
    start_date: i64,

    /// The Amazon Resource Name (ARN) that identifies the state machine.
    state_machine_arn: ?[]const u8 = null,

    /// The current status of the execution.
    status: SyncExecutionStatus,

    /// If the execution has already ended, the date the execution stopped.
    stop_date: i64,

    /// The X-Ray trace header that was passed to the execution.
    ///
    /// For X-Ray traces, all Amazon Web Services services use the `X-Amzn-Trace-Id`
    /// header from the HTTP request. Using the header is the preferred mechanism to
    /// identify a trace. `StartExecution` and `StartSyncExecution` API operations
    /// can also use `traceHeader` from the body of the request payload. If **both**
    /// sources are provided, Step Functions will use the **header value**
    /// (preferred) over the value in the request body.
    trace_header: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_details = "billingDetails",
        .cause = "cause",
        .@"error" = "error",
        .execution_arn = "executionArn",
        .input = "input",
        .input_details = "inputDetails",
        .name = "name",
        .output = "output",
        .output_details = "outputDetails",
        .start_date = "startDate",
        .state_machine_arn = "stateMachineArn",
        .status = "status",
        .stop_date = "stopDate",
        .trace_header = "traceHeader",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSyncExecutionInput, options: CallOptions) !StartSyncExecutionOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: StartSyncExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.StartSyncExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSyncExecutionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartSyncExecutionOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.ActivityAlreadyExists = aws.json.parseJsonObject(errors.ActivityAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .activity_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ActivityDoesNotExist")) {
        const parsed_error: ?errors.ActivityDoesNotExist = aws.json.parseJsonObject(errors.ActivityDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .activity_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ActivityLimitExceeded")) {
        const parsed_error: ?errors.ActivityLimitExceeded = aws.json.parseJsonObject(errors.ActivityLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .activity_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ActivityWorkerLimitExceeded")) {
        const parsed_error: ?errors.ActivityWorkerLimitExceeded = aws.json.parseJsonObject(errors.ActivityWorkerLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .activity_worker_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExecutionAlreadyExists")) {
        const parsed_error: ?errors.ExecutionAlreadyExists = aws.json.parseJsonObject(errors.ExecutionAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .execution_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExecutionDoesNotExist")) {
        const parsed_error: ?errors.ExecutionDoesNotExist = aws.json.parseJsonObject(errors.ExecutionDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .execution_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExecutionLimitExceeded")) {
        const parsed_error: ?errors.ExecutionLimitExceeded = aws.json.parseJsonObject(errors.ExecutionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .execution_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExecutionNotRedrivable")) {
        const parsed_error: ?errors.ExecutionNotRedrivable = aws.json.parseJsonObject(errors.ExecutionNotRedrivable, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .execution_not_redrivable = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidArn")) {
        const parsed_error: ?errors.InvalidArn = aws.json.parseJsonObject(errors.InvalidArn, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_arn = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDefinition")) {
        const parsed_error: ?errors.InvalidDefinition = aws.json.parseJsonObject(errors.InvalidDefinition, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_definition = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEncryptionConfiguration")) {
        const parsed_error: ?errors.InvalidEncryptionConfiguration = aws.json.parseJsonObject(errors.InvalidEncryptionConfiguration, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_encryption_configuration = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidExecutionInput")) {
        const parsed_error: ?errors.InvalidExecutionInput = aws.json.parseJsonObject(errors.InvalidExecutionInput, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_execution_input = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLoggingConfiguration")) {
        const parsed_error: ?errors.InvalidLoggingConfiguration = aws.json.parseJsonObject(errors.InvalidLoggingConfiguration, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_logging_configuration = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidName")) {
        const parsed_error: ?errors.InvalidName = aws.json.parseJsonObject(errors.InvalidName, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_name = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOutput")) {
        const parsed_error: ?errors.InvalidOutput = aws.json.parseJsonObject(errors.InvalidOutput, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_output = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidToken")) {
        const parsed_error: ?errors.InvalidToken = aws.json.parseJsonObject(errors.InvalidToken, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_token = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTracingConfiguration")) {
        const parsed_error: ?errors.InvalidTracingConfiguration = aws.json.parseJsonObject(errors.InvalidTracingConfiguration, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tracing_configuration = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsAccessDeniedException")) {
        const parsed_error: ?errors.KmsAccessDeniedException = aws.json.parseJsonObject(errors.KmsAccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsInvalidStateException")) {
        const parsed_error: ?errors.KmsInvalidStateException = aws.json.parseJsonObject(errors.KmsInvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsThrottlingException")) {
        const parsed_error: ?errors.KmsThrottlingException = aws.json.parseJsonObject(errors.KmsThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MissingRequiredParameter")) {
        const parsed_error: ?errors.MissingRequiredParameter = aws.json.parseJsonObject(errors.MissingRequiredParameter, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .missing_required_parameter = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        const parsed_error: ?errors.ResourceNotFound = aws.json.parseJsonObject(errors.ResourceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StateMachineAlreadyExists")) {
        const parsed_error: ?errors.StateMachineAlreadyExists = aws.json.parseJsonObject(errors.StateMachineAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .state_machine_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StateMachineDeleting")) {
        const parsed_error: ?errors.StateMachineDeleting = aws.json.parseJsonObject(errors.StateMachineDeleting, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .state_machine_deleting = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StateMachineDoesNotExist")) {
        const parsed_error: ?errors.StateMachineDoesNotExist = aws.json.parseJsonObject(errors.StateMachineDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .state_machine_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StateMachineLimitExceeded")) {
        const parsed_error: ?errors.StateMachineLimitExceeded = aws.json.parseJsonObject(errors.StateMachineLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .state_machine_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StateMachineTypeNotSupported")) {
        const parsed_error: ?errors.StateMachineTypeNotSupported = aws.json.parseJsonObject(errors.StateMachineTypeNotSupported, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .state_machine_type_not_supported = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TaskDoesNotExist")) {
        const parsed_error: ?errors.TaskDoesNotExist = aws.json.parseJsonObject(errors.TaskDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .task_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TaskTimedOut")) {
        const parsed_error: ?errors.TaskTimedOut = aws.json.parseJsonObject(errors.TaskTimedOut, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .task_timed_out = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTags")) {
        const parsed_error: ?errors.TooManyTags = aws.json.parseJsonObject(errors.TooManyTags, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
