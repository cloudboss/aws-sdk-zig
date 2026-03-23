const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MediaResource = @import("media_resource.zig").MediaResource;
const SuccessfulMonitorDeployment = @import("successful_monitor_deployment.zig").SuccessfulMonitorDeployment;
const MonitorDeployment = @import("monitor_deployment.zig").MonitorDeployment;
const SignalMapStatus = @import("signal_map_status.zig").SignalMapStatus;

pub const StartMonitorDeploymentInput = struct {
    dry_run: ?bool = null,

    /// A signal map's identifier. Can be either be its id or current name.
    identifier: []const u8,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .identifier = "Identifier",
    };
};

pub const StartMonitorDeploymentOutput = struct {
    /// A signal map's ARN (Amazon Resource Name)
    arn: ?[]const u8 = null,

    cloud_watch_alarm_template_group_ids: ?[]const []const u8 = null,

    created_at: ?i64 = null,

    /// A resource's optional description.
    description: ?[]const u8 = null,

    /// A top-level supported AWS resource ARN to discovery a signal map from.
    discovery_entry_point_arn: ?[]const u8 = null,

    /// Error message associated with a failed creation or failed update attempt of
    /// a signal map.
    error_message: ?[]const u8 = null,

    event_bridge_rule_template_group_ids: ?[]const []const u8 = null,

    failed_media_resource_map: ?[]const aws.map.MapEntry(MediaResource) = null,

    /// A signal map's id.
    id: ?[]const u8 = null,

    last_discovered_at: ?i64 = null,

    last_successful_monitor_deployment: ?SuccessfulMonitorDeployment = null,

    media_resource_map: ?[]const aws.map.MapEntry(MediaResource) = null,

    modified_at: ?i64 = null,

    /// If true, there are pending monitor changes for this signal map that can be
    /// deployed.
    monitor_changes_pending_deployment: ?bool = null,

    monitor_deployment: ?MonitorDeployment = null,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: ?[]const u8 = null,

    status: ?SignalMapStatus = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .cloud_watch_alarm_template_group_ids = "CloudWatchAlarmTemplateGroupIds",
        .created_at = "CreatedAt",
        .description = "Description",
        .discovery_entry_point_arn = "DiscoveryEntryPointArn",
        .error_message = "ErrorMessage",
        .event_bridge_rule_template_group_ids = "EventBridgeRuleTemplateGroupIds",
        .failed_media_resource_map = "FailedMediaResourceMap",
        .id = "Id",
        .last_discovered_at = "LastDiscoveredAt",
        .last_successful_monitor_deployment = "LastSuccessfulMonitorDeployment",
        .media_resource_map = "MediaResourceMap",
        .modified_at = "ModifiedAt",
        .monitor_changes_pending_deployment = "MonitorChangesPendingDeployment",
        .monitor_deployment = "MonitorDeployment",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMonitorDeploymentInput, options: CallOptions) !StartMonitorDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medialive");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMonitorDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/prod/signal-maps/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/monitor-deployment");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMonitorDeploymentOutput {
    var result: StartMonitorDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartMonitorDeploymentOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GatewayTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .gateway_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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
