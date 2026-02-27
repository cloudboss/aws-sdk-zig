const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMonitoringExecutionsInput, options: Options) !ListMonitoringExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListMonitoringExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.ListMonitoringExecutions");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListMonitoringExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMonitoringExecutionsOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
