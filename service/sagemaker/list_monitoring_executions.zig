const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const MonitoringType = @import("monitoring_type.zig").MonitoringType;
const MonitoringExecutionSortKey = @import("monitoring_execution_sort_key.zig").MonitoringExecutionSortKey;
const SortOrder = @import("sort_order.zig").SortOrder;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const MonitoringExecutionSummary = @import("monitoring_execution_summary.zig").MonitoringExecutionSummary;

pub const ListMonitoringExecutionsInput = struct {
    /// A filter that returns only jobs created after a specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only jobs created before a specified time.
    creation_time_before: ?i64 = null,

    /// Name of a specific endpoint to fetch jobs for.
    endpoint_name: ?[]const u8 = null,

    /// A filter that returns only jobs modified before a specified time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only jobs modified after a specified time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of jobs to return in the response. The default value is
    /// 10.
    max_results: ?i32 = null,

    /// Gets a list of the monitoring job runs of the specified monitoring job
    /// definitions.
    monitoring_job_definition_name: ?[]const u8 = null,

    /// Name of a specific schedule to fetch jobs for.
    monitoring_schedule_name: ?[]const u8 = null,

    /// A filter that returns only the monitoring job runs of the specified
    /// monitoring type.
    monitoring_type_equals: ?MonitoringType = null,

    /// The token returned if the response is truncated. To retrieve the next set of
    /// job executions, use it in the next request.
    next_token: ?[]const u8 = null,

    /// Filter for jobs scheduled after a specified time.
    scheduled_time_after: ?i64 = null,

    /// Filter for jobs scheduled before a specified time.
    scheduled_time_before: ?i64 = null,

    /// Whether to sort the results by the `Status`, `CreationTime`, or
    /// `ScheduledTime` field. The default is `CreationTime`.
    sort_by: ?MonitoringExecutionSortKey = null,

    /// Whether to sort the results in `Ascending` or `Descending` order. The
    /// default is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that retrieves only jobs with a specific status.
    status_equals: ?ExecutionStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .endpoint_name = "EndpointName",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .monitoring_job_definition_name = "MonitoringJobDefinitionName",
        .monitoring_schedule_name = "MonitoringScheduleName",
        .monitoring_type_equals = "MonitoringTypeEquals",
        .next_token = "NextToken",
        .scheduled_time_after = "ScheduledTimeAfter",
        .scheduled_time_before = "ScheduledTimeBefore",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListMonitoringExecutionsOutput = struct {
    /// A JSON array in which each element is a summary for a monitoring execution.
    monitoring_execution_summaries: ?[]const MonitoringExecutionSummary = null,

    /// The token returned if the response is truncated. To retrieve the next set of
    /// job executions, use it in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .monitoring_execution_summaries = "MonitoringExecutionSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMonitoringExecutionsInput, options: CallOptions) !ListMonitoringExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMonitoringExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListMonitoringExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMonitoringExecutionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListMonitoringExecutionsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        const parsed_error: ?errors.ResourceInUse = aws.json.parseJsonObject(errors.ResourceInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        const parsed_error: ?errors.ResourceLimitExceeded = aws.json.parseJsonObject(errors.ResourceLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = typed_error } };
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
