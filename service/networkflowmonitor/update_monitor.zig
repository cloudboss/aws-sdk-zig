const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MonitorLocalResource = @import("monitor_local_resource.zig").MonitorLocalResource;
const MonitorRemoteResource = @import("monitor_remote_resource.zig").MonitorRemoteResource;
const MonitorStatus = @import("monitor_status.zig").MonitorStatus;

pub const UpdateMonitorInput = struct {
    /// A unique, case-sensitive string of up to 64 ASCII characters that you
    /// specify to make an idempotent API request. Don't reuse the same client token
    /// for other API requests.
    client_token: ?[]const u8 = null,

    /// Additional local resources to specify network flows for a monitor, as an
    /// array of resources with identifiers and types. A local resource in a
    /// workload is the location of hosts where the Network Flow Monitor agent is
    /// installed.
    local_resources_to_add: ?[]const MonitorLocalResource = null,

    /// The local resources to remove, as an array of resources with identifiers and
    /// types.
    local_resources_to_remove: ?[]const MonitorLocalResource = null,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The remote resources to add, as an array of resources with identifiers and
    /// types.
    ///
    /// A remote resource is the other endpoint in the flow of a workload, with a
    /// local resource. For example, Amazon Dynamo DB can be a remote resource.
    remote_resources_to_add: ?[]const MonitorRemoteResource = null,

    /// The remote resources to remove, as an array of resources with identifiers
    /// and types.
    ///
    /// A remote resource is the other endpoint specified for the network flow of a
    /// workload, with a local resource. For example, Amazon Dynamo DB can be a
    /// remote resource.
    remote_resources_to_remove: ?[]const MonitorRemoteResource = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .local_resources_to_add = "localResourcesToAdd",
        .local_resources_to_remove = "localResourcesToRemove",
        .monitor_name = "monitorName",
        .remote_resources_to_add = "remoteResourcesToAdd",
        .remote_resources_to_remove = "remoteResourcesToRemove",
    };
};

pub const UpdateMonitorOutput = struct {
    /// The date and time when the monitor was created.
    created_at: i64,

    /// The local resources to monitor. A local resource in a workload is the
    /// location of hosts where the Network Flow Monitor agent is installed.
    local_resources: ?[]const MonitorLocalResource = null,

    /// The last date and time that the monitor was modified.
    modified_at: i64,

    /// The Amazon Resource Name (ARN) of the monitor.
    monitor_arn: []const u8,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The status of a monitor. The status can be one of the following
    ///
    /// * `PENDING`: The monitor is in the process of being created.
    /// * `ACTIVE`: The monitor is active.
    /// * `INACTIVE`: The monitor is inactive.
    /// * `ERROR`: Monitor creation failed due to an error.
    /// * `DELETING`: The monitor is in the process of being deleted.
    monitor_status: MonitorStatus,

    /// The remote resources updated for a monitor, as an array of resources with
    /// identifiers and types.
    ///
    /// A remote resource is the other endpoint specified for the network flow of a
    /// workload, with a local resource. For example, Amazon Dynamo DB can be a
    /// remote resource.
    remote_resources: ?[]const MonitorRemoteResource = null,

    /// The tags for a monitor.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .local_resources = "localResources",
        .modified_at = "modifiedAt",
        .monitor_arn = "monitorArn",
        .monitor_name = "monitorName",
        .monitor_status = "monitorStatus",
        .remote_resources = "remoteResources",
        .tags = "tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMonitorInput, options: Options) !UpdateMonitorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "networkflowmonitor");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMonitorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.local_resources_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"localResourcesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.local_resources_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"localResourcesToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remote_resources_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"remoteResourcesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remote_resources_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"remoteResourcesToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMonitorOutput {
    var result: UpdateMonitorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateMonitorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
