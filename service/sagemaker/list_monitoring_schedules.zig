const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MonitoringType = @import("monitoring_type.zig").MonitoringType;
const MonitoringScheduleSortKey = @import("monitoring_schedule_sort_key.zig").MonitoringScheduleSortKey;
const SortOrder = @import("sort_order.zig").SortOrder;
const ScheduleStatus = @import("schedule_status.zig").ScheduleStatus;
const MonitoringScheduleSummary = @import("monitoring_schedule_summary.zig").MonitoringScheduleSummary;

pub const ListMonitoringSchedulesInput = struct {
    /// A filter that returns only monitoring schedules created after a specified
    /// time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only monitoring schedules created before a specified
    /// time.
    creation_time_before: ?i64 = null,

    /// Name of a specific endpoint to fetch schedules for.
    endpoint_name: ?[]const u8 = null,

    /// A filter that returns only monitoring schedules modified after a specified
    /// time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only monitoring schedules modified before a specified
    /// time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of jobs to return in the response. The default value is
    /// 10.
    max_results: ?i32 = null,

    /// Gets a list of the monitoring schedules for the specified monitoring job
    /// definition.
    monitoring_job_definition_name: ?[]const u8 = null,

    /// A filter that returns only the monitoring schedules for the specified
    /// monitoring type.
    monitoring_type_equals: ?MonitoringType = null,

    /// Filter for monitoring schedules whose name contains a specified string.
    name_contains: ?[]const u8 = null,

    /// The token returned if the response is truncated. To retrieve the next set of
    /// job executions, use it in the next request.
    next_token: ?[]const u8 = null,

    /// Whether to sort the results by the `Status`, `CreationTime`, or
    /// `ScheduledTime` field. The default is `CreationTime`.
    sort_by: ?MonitoringScheduleSortKey = null,

    /// Whether to sort the results in `Ascending` or `Descending` order. The
    /// default is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that returns only monitoring schedules modified before a specified
    /// time.
    status_equals: ?ScheduleStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .endpoint_name = "EndpointName",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .monitoring_job_definition_name = "MonitoringJobDefinitionName",
        .monitoring_type_equals = "MonitoringTypeEquals",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListMonitoringSchedulesOutput = struct {
    /// A JSON array in which each element is a summary for a monitoring schedule.
    monitoring_schedule_summaries: ?[]const MonitoringScheduleSummary = null,

    /// The token returned if the response is truncated. To retrieve the next set of
    /// job executions, use it in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .monitoring_schedule_summaries = "MonitoringScheduleSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMonitoringSchedulesInput, options: CallOptions) !ListMonitoringSchedulesOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListMonitoringSchedulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListMonitoringSchedules");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMonitoringSchedulesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListMonitoringSchedulesOutput, body, allocator);
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
