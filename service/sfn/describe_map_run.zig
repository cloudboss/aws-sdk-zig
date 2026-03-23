const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MapRunExecutionCounts = @import("map_run_execution_counts.zig").MapRunExecutionCounts;
const MapRunItemCounts = @import("map_run_item_counts.zig").MapRunItemCounts;
const MapRunStatus = @import("map_run_status.zig").MapRunStatus;

pub const DescribeMapRunInput = struct {
    /// The Amazon Resource Name (ARN) that identifies a Map Run.
    map_run_arn: []const u8,

    pub const json_field_names = .{
        .map_run_arn = "mapRunArn",
    };
};

pub const DescribeMapRunOutput = struct {
    /// The Amazon Resource Name (ARN) that identifies the execution in which the
    /// Map Run was started.
    execution_arn: []const u8,

    /// A JSON object that contains information about the total number of child
    /// workflow executions for the Map Run, and the count of child workflow
    /// executions for each status, such as `failed` and `succeeded`.
    execution_counts: ?MapRunExecutionCounts = null,

    /// A JSON object that contains information about the total number of items, and
    /// the item count for each processing status, such as `pending` and `failed`.
    item_counts: ?MapRunItemCounts = null,

    /// The Amazon Resource Name (ARN) that identifies a Map Run.
    map_run_arn: []const u8,

    /// The maximum number of child workflow executions configured to run in
    /// parallel for the Map Run at the same time.
    max_concurrency: ?i32 = null,

    /// The number of times you've redriven a Map Run. If you have not yet redriven
    /// a Map Run, the `redriveCount` is 0. This count is only updated if you
    /// successfully redrive a Map Run.
    redrive_count: ?i32 = null,

    /// The date a Map Run was last redriven. If you have not yet redriven a Map
    /// Run, the `redriveDate` is null.
    redrive_date: ?i64 = null,

    /// The date when the Map Run was started.
    start_date: i64,

    /// The current status of the Map Run.
    status: MapRunStatus,

    /// The date when the Map Run was stopped.
    stop_date: ?i64 = null,

    /// The maximum number of failed child workflow executions before the Map Run
    /// fails.
    tolerated_failure_count: ?i64 = null,

    /// The maximum percentage of failed child workflow executions before the Map
    /// Run fails.
    tolerated_failure_percentage: ?f32 = null,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .execution_counts = "executionCounts",
        .item_counts = "itemCounts",
        .map_run_arn = "mapRunArn",
        .max_concurrency = "maxConcurrency",
        .redrive_count = "redriveCount",
        .redrive_date = "redriveDate",
        .start_date = "startDate",
        .status = "status",
        .stop_date = "stopDate",
        .tolerated_failure_count = "toleratedFailureCount",
        .tolerated_failure_percentage = "toleratedFailurePercentage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMapRunInput, options: CallOptions) !DescribeMapRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMapRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.DescribeMapRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMapRunOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeMapRunOutput, body, allocator);
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
