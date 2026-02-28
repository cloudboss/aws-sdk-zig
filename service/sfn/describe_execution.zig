const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IncludedData = @import("included_data.zig").IncludedData;
const CloudWatchEventsExecutionDataDetails = @import("cloud_watch_events_execution_data_details.zig").CloudWatchEventsExecutionDataDetails;
const ExecutionRedriveStatus = @import("execution_redrive_status.zig").ExecutionRedriveStatus;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

pub const DescribeExecutionInput = struct {
    /// The Amazon Resource Name (ARN) of the execution to describe.
    execution_arn: []const u8,

    /// If your state machine definition is encrypted with a KMS key, callers must
    /// have `kms:Decrypt` permission to decrypt the definition. Alternatively, you
    /// can call DescribeStateMachine API with `includedData = METADATA_ONLY` to get
    /// a successful response without the encrypted definition.
    included_data: ?IncludedData = null,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .included_data = "includedData",
    };
};

pub const DescribeExecutionOutput = struct {
    /// The cause string if the state machine execution failed.
    cause: ?[]const u8 = null,

    /// The error string if the state machine execution failed.
    @"error": ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the execution.
    execution_arn: []const u8,

    /// The string that contains the JSON input data of the execution. Length
    /// constraints apply to the payload size, and are expressed as bytes in UTF-8
    /// encoding.
    input: ?[]const u8 = null,

    input_details: ?CloudWatchEventsExecutionDataDetails = null,

    /// The Amazon Resource Name (ARN) that identifies a Map Run, which dispatched
    /// this execution.
    map_run_arn: ?[]const u8 = null,

    /// The name of the execution.
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

    /// The JSON output data of the execution. Length constraints apply to the
    /// payload size, and are expressed as bytes in UTF-8 encoding.
    ///
    /// This field is set only if the execution succeeds. If the execution fails,
    /// this field is
    /// null.
    output: ?[]const u8 = null,

    output_details: ?CloudWatchEventsExecutionDataDetails = null,

    /// The number of times you've redriven an execution. If you have not yet
    /// redriven an execution, the `redriveCount` is 0. This count is only updated
    /// if you successfully redrive an execution.
    redrive_count: ?i32 = null,

    /// The date the execution was last redriven. If you have not yet redriven an
    /// execution, the `redriveDate` is null.
    ///
    /// The `redriveDate` is unavailable if you redrive a Map Run that starts child
    /// workflow executions of type `EXPRESS`.
    redrive_date: ?i64 = null,

    /// Indicates whether or not an execution can be redriven at a given point in
    /// time.
    ///
    /// * For executions of type `STANDARD`, `redriveStatus` is `NOT_REDRIVABLE` if
    ///   calling the RedriveExecution API action would return the
    ///   `ExecutionNotRedrivable` error.
    ///
    /// * For a Distributed Map that includes child workflows of type `STANDARD`,
    ///   `redriveStatus` indicates whether or not the Map Run can redrive child
    ///   workflow executions.
    ///
    /// * For a Distributed Map that includes child workflows of type `EXPRESS`,
    ///   `redriveStatus` indicates whether or not the Map Run can redrive child
    ///   workflow executions.
    ///
    /// You can redrive failed or timed out `EXPRESS` workflows *only if* they're a
    /// part of a Map Run. When you
    /// [redrive](https://docs.aws.amazon.com/step-functions/latest/dg/redrive-map-run.html) the Map Run, these workflows are restarted using the StartExecution API action.
    redrive_status: ?ExecutionRedriveStatus = null,

    /// When `redriveStatus` is `NOT_REDRIVABLE`, `redriveStatusReason` specifies
    /// the reason why an execution cannot be redriven.
    ///
    /// * For executions of type `STANDARD`, or for a Distributed Map that includes
    ///   child workflows of type `STANDARD`, `redriveStatusReason` can include one
    ///   of the following reasons:
    ///
    /// * `State machine is in DELETING status`.
    ///
    /// * `Execution is RUNNING and cannot be redriven`.
    ///
    /// * `Execution is SUCCEEDED and cannot be redriven`.
    ///
    /// * `Execution was started before the launch of RedriveExecution`.
    ///
    /// * `Execution history event limit exceeded`.
    ///
    /// * `Execution has exceeded the max execution time`.
    ///
    /// * `Execution redrivable period exceeded`.
    ///
    /// * For a Distributed Map that includes child workflows of type `EXPRESS`,
    ///   `redriveStatusReason` is only returned if the child workflows are not
    ///   redrivable. This happens when the child workflow executions have completed
    ///   successfully.
    redrive_status_reason: ?[]const u8 = null,

    /// The date the execution is started.
    start_date: i64,

    /// The Amazon Resource Name (ARN) of the state machine alias associated with
    /// the execution. The alias ARN is a combination of state machine ARN and the
    /// alias name separated by a colon (:). For example, `stateMachineARN:PROD`.
    ///
    /// If you start an execution from a `StartExecution` request with a
    /// state machine version ARN, this field will be null.
    state_machine_alias_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the executed stated machine.
    state_machine_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the state machine version associated with
    /// the execution. The version ARN is a combination of state machine ARN and the
    /// version number separated by a colon (:). For example, `stateMachineARN:1`.
    ///
    /// If you start an execution from a `StartExecution` request without specifying
    /// a
    /// state machine version or alias ARN, Step Functions returns a null value.
    state_machine_version_arn: ?[]const u8 = null,

    /// The current status of the execution.
    status: ExecutionStatus,

    /// If the execution ended, the date the execution stopped.
    stop_date: ?i64 = null,

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
        .cause = "cause",
        .@"error" = "error",
        .execution_arn = "executionArn",
        .input = "input",
        .input_details = "inputDetails",
        .map_run_arn = "mapRunArn",
        .name = "name",
        .output = "output",
        .output_details = "outputDetails",
        .redrive_count = "redriveCount",
        .redrive_date = "redriveDate",
        .redrive_status = "redriveStatus",
        .redrive_status_reason = "redriveStatusReason",
        .start_date = "startDate",
        .state_machine_alias_arn = "stateMachineAliasArn",
        .state_machine_arn = "stateMachineArn",
        .state_machine_version_arn = "stateMachineVersionArn",
        .status = "status",
        .stop_date = "stopDate",
        .trace_header = "traceHeader",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeExecutionInput, options: Options) !DescribeExecutionOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSStepFunctions.DescribeExecution");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeExecutionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeExecutionOutput, body, alloc);
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
