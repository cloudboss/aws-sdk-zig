const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DeviceState = @import("device_state.zig").DeviceState;
const DistanceUnit = @import("distance_unit.zig").DistanceUnit;
const InferredState = @import("inferred_state.zig").InferredState;

pub const VerifyDevicePositionInput = struct {
    /// The device's state, including position, IP address, cell signals and Wi-Fi
    /// access points.
    device_state: DeviceState,

    /// The distance unit for the verification request.
    ///
    /// Default Value: `Kilometers`
    distance_unit: ?DistanceUnit = null,

    /// The name of the tracker resource to be associated with verification request.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .device_state = "DeviceState",
        .distance_unit = "DistanceUnit",
        .tracker_name = "TrackerName",
    };
};

pub const VerifyDevicePositionOutput = struct {
    /// The device identifier.
    device_id: []const u8,

    /// The distance unit for the verification response.
    distance_unit: DistanceUnit,

    /// The inferred state of the device, given the provided position, IP address,
    /// cellular signals, and Wi-Fi- access points.
    inferred_state: ?InferredState = null,

    /// The timestamp for when the tracker resource received the device position in
    /// [ ISO 8601 ](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    received_time: i64,

    /// The timestamp at which the device's position was determined. Uses [ ISO 8601
    /// ](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    sample_time: i64,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .distance_unit = "DistanceUnit",
        .inferred_state = "InferredState",
        .received_time = "ReceivedTime",
        .sample_time = "SampleTime",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyDevicePositionInput, options: Options) !VerifyDevicePositionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "location");

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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyDevicePositionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("location", "Location", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/tracking/v0/trackers/");
    try path_buf.appendSlice(allocator, input.tracker_name);
    try path_buf.appendSlice(allocator, "/positions/verify");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeviceState\":");
    try aws.json.writeValue(@TypeOf(input.device_state), input.device_state, allocator, &body_buf);
    has_prev = true;
    if (input.distance_unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DistanceUnit\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyDevicePositionOutput {
    var result: VerifyDevicePositionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(VerifyDevicePositionOutput, body, allocator);
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
