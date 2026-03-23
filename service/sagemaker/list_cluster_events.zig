const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ClusterEventResourceType = @import("cluster_event_resource_type.zig").ClusterEventResourceType;
const EventSortBy = @import("event_sort_by.zig").EventSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ClusterEventSummary = @import("cluster_event_summary.zig").ClusterEventSummary;

pub const ListClusterEventsInput = struct {
    /// The name or Amazon Resource Name (ARN) of the HyperPod cluster for which to
    /// list events.
    cluster_name: []const u8,

    /// The start of the time range for filtering events. Only events that occurred
    /// after this time are included in the results.
    event_time_after: ?i64 = null,

    /// The end of the time range for filtering events. Only events that occurred
    /// before this time are included in the results.
    event_time_before: ?i64 = null,

    /// The name of the instance group to filter events. If specified, only events
    /// related to this instance group are returned.
    instance_group_name: ?[]const u8 = null,

    /// The maximum number of events to return in the response. Valid range is 1 to
    /// 100.
    max_results: ?i32 = null,

    /// A token to retrieve the next set of results. This token is obtained from the
    /// output of a previous `ListClusterEvents` call.
    next_token: ?[]const u8 = null,

    /// The EC2 instance ID to filter events. If specified, only events related to
    /// this instance are returned.
    node_id: ?[]const u8 = null,

    /// The type of resource for which to filter events. Valid values are `Cluster`,
    /// `InstanceGroup`, or `Instance`.
    resource_type: ?ClusterEventResourceType = null,

    /// The field to use for sorting the event list. Currently, the only supported
    /// value is `EventTime`.
    sort_by: ?EventSortBy = null,

    /// The order in which to sort the results. Valid values are `Ascending` or
    /// `Descending` (the default is `Descending`).
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .event_time_after = "EventTimeAfter",
        .event_time_before = "EventTimeBefore",
        .instance_group_name = "InstanceGroupName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .node_id = "NodeId",
        .resource_type = "ResourceType",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListClusterEventsOutput = struct {
    /// A list of event summaries matching the specified criteria.
    events: ?[]const ClusterEventSummary = null,

    /// A token to retrieve the next set of results. Include this token in
    /// subsequent `ListClusterEvents` calls to fetch more events.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "Events",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClusterEventsInput, options: CallOptions) !ListClusterEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClusterEventsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListClusterEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClusterEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListClusterEventsOutput, body, allocator);
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
