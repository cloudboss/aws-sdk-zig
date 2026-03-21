const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EdgeModel = @import("edge_model.zig").EdgeModel;

pub const DescribeDeviceInput = struct {
    /// The name of the fleet the devices belong to.
    device_fleet_name: []const u8,

    /// The unique ID of the device.
    device_name: []const u8,

    /// Next token of device description.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_fleet_name = "DeviceFleetName",
        .device_name = "DeviceName",
        .next_token = "NextToken",
    };
};

pub const DescribeDeviceOutput = struct {
    /// Edge Manager agent version.
    agent_version: ?[]const u8 = null,

    /// A description of the device.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the device.
    device_arn: ?[]const u8 = null,

    /// The name of the fleet the device belongs to.
    device_fleet_name: []const u8,

    /// The unique identifier of the device.
    device_name: []const u8,

    /// The Amazon Web Services Internet of Things (IoT) object thing name
    /// associated with the device.
    iot_thing_name: ?[]const u8 = null,

    /// The last heartbeat received from the device.
    latest_heartbeat: ?i64 = null,

    /// The maximum number of models.
    max_models: ?i32 = null,

    /// Models on the device.
    models: ?[]const EdgeModel = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    /// The timestamp of the last registration or de-reregistration.
    registration_time: i64,

    pub const json_field_names = .{
        .agent_version = "AgentVersion",
        .description = "Description",
        .device_arn = "DeviceArn",
        .device_fleet_name = "DeviceFleetName",
        .device_name = "DeviceName",
        .iot_thing_name = "IotThingName",
        .latest_heartbeat = "LatestHeartbeat",
        .max_models = "MaxModels",
        .models = "Models",
        .next_token = "NextToken",
        .registration_time = "RegistrationTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDeviceInput, options: CallOptions) !DescribeDeviceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDeviceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeDevice");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDeviceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeDeviceOutput, body, allocator);
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
