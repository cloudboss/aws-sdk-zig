const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const WirelessDeviceIdType = @import("wireless_device_id_type.zig").WirelessDeviceIdType;
const LoRaWANDevice = @import("lo_ra_wan_device.zig").LoRaWANDevice;
const PositioningConfigStatus = @import("positioning_config_status.zig").PositioningConfigStatus;
const SidewalkDevice = @import("sidewalk_device.zig").SidewalkDevice;
const WirelessDeviceType = @import("wireless_device_type.zig").WirelessDeviceType;

pub const GetWirelessDeviceInput = struct {
    /// The identifier of the wireless device to get.
    identifier: []const u8,

    /// The type of identifier used in `identifier`.
    identifier_type: WirelessDeviceIdType,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .identifier_type = "IdentifierType",
    };
};

pub const GetWirelessDeviceOutput = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// The description of the resource.
    description: ?[]const u8 = null,

    /// The name of the destination to which the device is assigned.
    destination_name: ?[]const u8 = null,

    /// The ID of the wireless device.
    id: ?[]const u8 = null,

    /// Information about the wireless device.
    lo_ra_wan: ?LoRaWANDevice = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// The integration status of the Device Location feature for LoRaWAN and
    /// Sidewalk devices.
    positioning: ?PositioningConfigStatus = null,

    /// Sidewalk device object.
    sidewalk: ?SidewalkDevice = null,

    /// The ARN of the thing associated with the wireless device.
    thing_arn: ?[]const u8 = null,

    /// The name of the thing associated with the wireless device. The value is
    /// empty if a
    /// thing isn't associated with the device.
    thing_name: ?[]const u8 = null,

    /// The wireless device type.
    @"type": ?WirelessDeviceType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .destination_name = "DestinationName",
        .id = "Id",
        .lo_ra_wan = "LoRaWAN",
        .name = "Name",
        .positioning = "Positioning",
        .sidewalk = "Sidewalk",
        .thing_arn = "ThingArn",
        .thing_name = "ThingName",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWirelessDeviceInput, options: CallOptions) !GetWirelessDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotwireless");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWirelessDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/wireless-devices/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "identifierType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.identifier_type.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWirelessDeviceOutput {
    var result: GetWirelessDeviceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWirelessDeviceOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
