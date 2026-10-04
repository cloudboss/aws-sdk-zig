const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoRaWANUpdateDevice = @import("lo_ra_wan_update_device.zig").LoRaWANUpdateDevice;
const PositioningConfigStatus = @import("positioning_config_status.zig").PositioningConfigStatus;
const SidewalkUpdateWirelessDevice = @import("sidewalk_update_wireless_device.zig").SidewalkUpdateWirelessDevice;

pub const UpdateWirelessDeviceInput = struct {
    /// A new description of the resource.
    description: ?[]const u8 = null,

    /// The name of the new destination for the device.
    destination_name: ?[]const u8 = null,

    /// The ID of the resource to update.
    id: []const u8,

    /// The updated wireless device's configuration.
    lo_ra_wan: ?LoRaWANUpdateDevice = null,

    /// The new name of the resource.
    ///
    /// The following special characters aren't accepted: `<>^#~$`
    name: ?[]const u8 = null,

    /// The integration status of the Device Location feature for LoRaWAN and
    /// Sidewalk devices.
    positioning: ?PositioningConfigStatus = null,

    /// The updated sidewalk properties.
    sidewalk: ?SidewalkUpdateWirelessDevice = null,

    pub const json_field_names = .{
        .description = "Description",
        .destination_name = "DestinationName",
        .id = "Id",
        .lo_ra_wan = "LoRaWAN",
        .name = "Name",
        .positioning = "Positioning",
        .sidewalk = "Sidewalk",
    };
};

pub const UpdateWirelessDeviceOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWirelessDeviceInput, options: CallOptions) !UpdateWirelessDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWirelessDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/wireless-devices/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.destination_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lo_ra_wan) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LoRaWAN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.positioning) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Positioning\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sidewalk) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Sidewalk\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWirelessDeviceOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateWirelessDeviceOutput = .{};

    return result;
}
