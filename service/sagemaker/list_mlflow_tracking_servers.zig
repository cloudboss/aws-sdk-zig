const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SortTrackingServerBy = @import("sort_tracking_server_by.zig").SortTrackingServerBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const TrackingServerStatus = @import("tracking_server_status.zig").TrackingServerStatus;
const TrackingServerSummary = @import("tracking_server_summary.zig").TrackingServerSummary;

pub const ListMlflowTrackingServersInput = struct {
    /// Use the `CreatedAfter` filter to only list tracking servers created after a
    /// specific date and time. Listed tracking servers are shown with a date and
    /// time such as `"2024-03-16T01:46:56+00:00"`. The `CreatedAfter` parameter
    /// takes in a Unix timestamp. To convert a date and time into a Unix timestamp,
    /// see [EpochConverter](https://www.epochconverter.com/).
    created_after: ?i64 = null,

    /// Use the `CreatedBefore` filter to only list tracking servers created before
    /// a specific date and time. Listed tracking servers are shown with a date and
    /// time such as `"2024-03-16T01:46:56+00:00"`. The `CreatedBefore` parameter
    /// takes in a Unix timestamp. To convert a date and time into a Unix timestamp,
    /// see [EpochConverter](https://www.epochconverter.com/).
    created_before: ?i64 = null,

    /// The maximum number of tracking servers to list.
    max_results: ?i32 = null,

    /// Filter for tracking servers using the specified MLflow version.
    mlflow_version: ?[]const u8 = null,

    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// Filter for trackings servers sorting by name, creation time, or creation
    /// status.
    sort_by: ?SortTrackingServerBy = null,

    /// Change the order of the listed tracking servers. By default, tracking
    /// servers are listed in `Descending` order by creation time. To change the
    /// list order, you can specify `SortOrder` to be `Ascending`.
    sort_order: ?SortOrder = null,

    /// Filter for tracking servers with a specified creation status.
    tracking_server_status: ?TrackingServerStatus = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .max_results = "MaxResults",
        .mlflow_version = "MlflowVersion",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .tracking_server_status = "TrackingServerStatus",
    };
};

pub const ListMlflowTrackingServersOutput = struct {
    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// A list of tracking servers according to chosen filters.
    tracking_server_summaries: ?[]const TrackingServerSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tracking_server_summaries = "TrackingServerSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMlflowTrackingServersInput, options: CallOptions) !ListMlflowTrackingServersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMlflowTrackingServersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListMlflowTrackingServers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMlflowTrackingServersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMlflowTrackingServersOutput, body, allocator);
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
