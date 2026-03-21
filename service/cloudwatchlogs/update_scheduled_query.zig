const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const QueryLanguage = @import("query_language.zig").QueryLanguage;
const ScheduledQueryState = @import("scheduled_query_state.zig").ScheduledQueryState;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

pub const UpdateScheduledQueryInput = struct {
    /// An updated description for the scheduled query.
    description: ?[]const u8 = null,

    /// The updated configuration for where to deliver query results.
    destination_configuration: ?DestinationConfiguration = null,

    /// The updated ARN of the IAM role that grants permissions to execute the query
    /// and deliver
    /// results.
    execution_role_arn: []const u8,

    /// The ARN or name of the scheduled query to update.
    identifier: []const u8,

    /// The updated array of log group names or ARNs to query.
    log_group_identifiers: ?[]const []const u8 = null,

    /// The updated query language for the scheduled query.
    query_language: QueryLanguage,

    /// The updated query string to execute.
    query_string: []const u8,

    /// The updated end time for the scheduled query in Unix epoch format.
    schedule_end_time: ?i64 = null,

    /// The updated cron expression that defines when the scheduled query runs.
    schedule_expression: []const u8,

    /// The updated start time for the scheduled query in Unix epoch format.
    schedule_start_time: ?i64 = null,

    /// The updated time offset in seconds that defines the lookback period for the
    /// query.
    start_time_offset: ?i64 = null,

    /// The updated state of the scheduled query.
    state: ?ScheduledQueryState = null,

    /// The updated timezone for evaluating the schedule expression.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .destination_configuration = "destinationConfiguration",
        .execution_role_arn = "executionRoleArn",
        .identifier = "identifier",
        .log_group_identifiers = "logGroupIdentifiers",
        .query_language = "queryLanguage",
        .query_string = "queryString",
        .schedule_end_time = "scheduleEndTime",
        .schedule_expression = "scheduleExpression",
        .schedule_start_time = "scheduleStartTime",
        .start_time_offset = "startTimeOffset",
        .state = "state",
        .timezone = "timezone",
    };
};

pub const UpdateScheduledQueryOutput = struct {
    /// The timestamp when the scheduled query was originally created.
    creation_time: ?i64 = null,

    /// The description of the updated scheduled query.
    description: ?[]const u8 = null,

    /// The destination configuration of the updated scheduled query.
    destination_configuration: ?DestinationConfiguration = null,

    /// The execution role ARN of the updated scheduled query.
    execution_role_arn: ?[]const u8 = null,

    /// The status of the most recent execution of the updated scheduled query.
    last_execution_status: ?ExecutionStatus = null,

    /// The timestamp when the updated scheduled query was last executed.
    last_triggered_time: ?i64 = null,

    /// The timestamp when the scheduled query was last updated.
    last_updated_time: ?i64 = null,

    /// The log groups queried by the updated scheduled query.
    log_group_identifiers: ?[]const []const u8 = null,

    /// The name of the updated scheduled query.
    name: ?[]const u8 = null,

    /// The query language of the updated scheduled query.
    query_language: ?QueryLanguage = null,

    /// The query string of the updated scheduled query.
    query_string: ?[]const u8 = null,

    /// The ARN of the updated scheduled query.
    scheduled_query_arn: ?[]const u8 = null,

    /// The end time of the updated scheduled query.
    schedule_end_time: ?i64 = null,

    /// The cron expression of the updated scheduled query.
    schedule_expression: ?[]const u8 = null,

    /// The start time of the updated scheduled query.
    schedule_start_time: ?i64 = null,

    /// The time offset of the updated scheduled query.
    start_time_offset: ?i64 = null,

    /// The state of the updated scheduled query.
    state: ?ScheduledQueryState = null,

    /// The timezone of the updated scheduled query.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .destination_configuration = "destinationConfiguration",
        .execution_role_arn = "executionRoleArn",
        .last_execution_status = "lastExecutionStatus",
        .last_triggered_time = "lastTriggeredTime",
        .last_updated_time = "lastUpdatedTime",
        .log_group_identifiers = "logGroupIdentifiers",
        .name = "name",
        .query_language = "queryLanguage",
        .query_string = "queryString",
        .scheduled_query_arn = "scheduledQueryArn",
        .schedule_end_time = "scheduleEndTime",
        .schedule_expression = "scheduleExpression",
        .schedule_start_time = "scheduleStartTime",
        .start_time_offset = "startTimeOffset",
        .state = "state",
        .timezone = "timezone",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScheduledQueryInput, options: CallOptions) !UpdateScheduledQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "logs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateScheduledQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.UpdateScheduledQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateScheduledQueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateScheduledQueryOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "DataAlreadyAcceptedException")) {
        return .{ .arena = arena, .kind = .{ .data_already_accepted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSequenceTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sequence_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedQueryException")) {
        return .{ .arena = arena, .kind = .{ .malformed_query_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationAbortedException")) {
        return .{ .arena = arena, .kind = .{ .operation_aborted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnrecognizedClientException")) {
        return .{ .arena = arena, .kind = .{ .unrecognized_client_exception = .{
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
