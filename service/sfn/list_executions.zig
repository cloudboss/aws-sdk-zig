const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExecutionRedriveFilter = @import("execution_redrive_filter.zig").ExecutionRedriveFilter;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const ExecutionListItem = @import("execution_list_item.zig").ExecutionListItem;

pub const ListExecutionsInput = struct {
    /// The Amazon Resource Name (ARN) of the Map Run that started the child
    /// workflow executions. If the `mapRunArn` field is specified, a list of all of
    /// the child workflow executions started by a Map Run is returned. For more
    /// information, see [Examining Map
    /// Run](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-examine-map-run.html) in the *Step Functions Developer Guide*.
    ///
    /// You can specify either a `mapRunArn` or a `stateMachineArn`, but not both.
    map_run_arn: ?[]const u8 = null,

    /// The maximum number of results that are returned per call. You can use
    /// `nextToken` to obtain further pages of results.
    /// The default is 100 and the maximum allowed page size is 1000. A value of 0
    /// uses the default.
    ///
    /// This is only an upper limit. The actual number of results returned per call
    /// might be fewer than the specified maximum.
    max_results: ?i32 = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    next_token: ?[]const u8 = null,

    /// Sets a filter to list executions based on whether or not they have been
    /// redriven.
    ///
    /// For a Distributed Map, `redriveFilter` sets a filter to list child workflow
    /// executions based on whether or not they have been redriven.
    ///
    /// If you do not provide a `redriveFilter`, Step Functions returns a list of
    /// both redriven and non-redriven executions.
    ///
    /// If you provide a state machine ARN in `redriveFilter`, the API returns a
    /// validation exception.
    redrive_filter: ?ExecutionRedriveFilter = null,

    /// The Amazon Resource Name (ARN) of the state machine whose executions is
    /// listed.
    ///
    /// You can specify either a `mapRunArn` or a `stateMachineArn`, but not both.
    ///
    /// You can also return a list of executions associated with a specific
    /// [alias](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-alias.html) or [version](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-state-machine-version.html), by specifying an alias ARN or a version ARN in the `stateMachineArn` parameter.
    state_machine_arn: ?[]const u8 = null,

    /// If specified, only list the executions whose current execution status
    /// matches the given
    /// filter.
    ///
    /// If you provide a `PENDING_REDRIVE` statusFilter, you must specify
    /// `mapRunArn`.
    /// For more information, see [Child workflow execution redrive
    /// behaviour](https://docs.aws.amazon.com/step-functions/latest/dg/redrive-map-run.html#redrive-child-workflow-behavior)
    /// in the *Step Functions Developer Guide*.
    ///
    /// If you provide a stateMachineArn and a `PENDING_REDRIVE` statusFilter, the
    /// API returns a validation exception.
    status_filter: ?ExecutionStatus = null,

    pub const json_field_names = .{
        .map_run_arn = "mapRunArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .redrive_filter = "redriveFilter",
        .state_machine_arn = "stateMachineArn",
        .status_filter = "statusFilter",
    };
};

pub const ListExecutionsOutput = struct {
    /// The list of matching executions.
    executions: ?[]const ExecutionListItem = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    /// Make the call again using the returned token to retrieve the next page. Keep
    /// all other arguments unchanged. Each pagination token expires after 24 hours.
    /// Using an expired pagination token will return an *HTTP 400 InvalidToken*
    /// error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .executions = "executions",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExecutionsInput, options: Options) !ListExecutionsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListExecutionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSStepFunctions.ListExecutions");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListExecutionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListExecutionsOutput, body, alloc);
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
