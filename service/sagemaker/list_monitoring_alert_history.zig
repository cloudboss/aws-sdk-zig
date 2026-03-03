const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MonitoringAlertHistorySortKey = @import("monitoring_alert_history_sort_key.zig").MonitoringAlertHistorySortKey;
const SortOrder = @import("sort_order.zig").SortOrder;
const MonitoringAlertStatus = @import("monitoring_alert_status.zig").MonitoringAlertStatus;
const MonitoringAlertHistorySummary = @import("monitoring_alert_history_summary.zig").MonitoringAlertHistorySummary;

pub const ListMonitoringAlertHistoryInput = struct {
    /// A filter that returns only alerts created on or after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only alerts created on or before the specified time.
    creation_time_before: ?i64 = null,

    /// The maximum number of results to display. The default is 100.
    max_results: ?i32 = null,

    /// The name of a monitoring alert.
    monitoring_alert_name: ?[]const u8 = null,

    /// The name of a monitoring schedule.
    monitoring_schedule_name: ?[]const u8 = null,

    /// If the result of the previous `ListMonitoringAlertHistory` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// alerts in the history, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field used to sort results. The default is `CreationTime`.
    sort_by: ?MonitoringAlertHistorySortKey = null,

    /// The sort order, whether `Ascending` or `Descending`, of the alert history.
    /// The default is `Descending`.
    sort_order: ?SortOrder = null,

    /// A filter that retrieves only alerts with a specific status.
    status_equals: ?MonitoringAlertStatus = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .monitoring_alert_name = "MonitoringAlertName",
        .monitoring_schedule_name = "MonitoringScheduleName",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status_equals = "StatusEquals",
    };
};

pub const ListMonitoringAlertHistoryOutput = struct {
    /// An alert history for a model monitoring schedule.
    monitoring_alert_history: ?[]const MonitoringAlertHistorySummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of alerts, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .monitoring_alert_history = "MonitoringAlertHistory",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMonitoringAlertHistoryInput, options: CallOptions) !ListMonitoringAlertHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMonitoringAlertHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListMonitoringAlertHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMonitoringAlertHistoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMonitoringAlertHistoryOutput, body, allocator);
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
