const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EdgeMetric = @import("edge_metric.zig").EdgeMetric;
const DeploymentResult = @import("deployment_result.zig").DeploymentResult;
const Model = @import("model.zig").Model;

pub const SendHeartbeatInput = struct {
    /// For internal use. Returns a list of SageMaker Edge Manager agent operating
    /// metrics.
    agent_metrics: ?[]const EdgeMetric = null,

    /// Returns the version of the agent.
    agent_version: []const u8,

    /// Returns the result of a deployment on the device.
    deployment_result: ?DeploymentResult = null,

    /// The name of the fleet that the device belongs to.
    device_fleet_name: []const u8,

    /// The unique name of the device.
    device_name: []const u8,

    /// Returns a list of models deployed on the the device.
    models: ?[]const Model = null,

    pub const json_field_names = .{
        .agent_metrics = "AgentMetrics",
        .agent_version = "AgentVersion",
        .deployment_result = "DeploymentResult",
        .device_fleet_name = "DeviceFleetName",
        .device_name = "DeviceName",
        .models = "Models",
    };
};

const SendHeartbeatOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendHeartbeatInput, options: Options) !SendHeartbeatOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemakeredge");

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

fn serializeRequest(alloc: std.mem.Allocator, input: SendHeartbeatInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemakeredge", "Sagemaker Edge", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/SendHeartbeat";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.agent_metrics) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AgentMetrics\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"AgentVersion\":");
    try aws.json.writeValue(@TypeOf(input.agent_version), input.agent_version, alloc, &body_buf);
    has_prev = true;
    if (input.deployment_result) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DeploymentResult\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"DeviceFleetName\":");
    try aws.json.writeValue(@TypeOf(input.device_fleet_name), input.device_fleet_name, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"DeviceName\":");
    try aws.json.writeValue(@TypeOf(input.device_name), input.device_name, alloc, &body_buf);
    has_prev = true;
    if (input.models) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Models\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SendHeartbeatOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: SendHeartbeatOutput = .{};

    return result;
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

    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
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
