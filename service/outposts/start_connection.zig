const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartConnectionInput = struct {
    /// The ID of the Outpost server.
    asset_id: []const u8,

    /// The public key of the client.
    client_public_key: []const u8,

    /// The serial number of the dongle.
    device_serial_number: ?[]const u8 = null,

    /// The device index of the network interface on the Outpost server.
    network_interface_device_index: ?i32 = null,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .client_public_key = "ClientPublicKey",
        .device_serial_number = "DeviceSerialNumber",
        .network_interface_device_index = "NetworkInterfaceDeviceIndex",
    };
};

pub const StartConnectionOutput = struct {
    /// The ID of the connection.
    connection_id: ?[]const u8 = null,

    /// The underlay IP address.
    underlay_ip_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_id = "ConnectionId",
        .underlay_ip_address = "UnderlayIpAddress",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartConnectionInput, options: CallOptions) !StartConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connections";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AssetId\":");
    try aws.json.writeValue(@TypeOf(input.asset_id), input.asset_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientPublicKey\":");
    try aws.json.writeValue(@TypeOf(input.client_public_key), input.client_public_key, allocator, &body_buf);
    has_prev = true;
    if (input.device_serial_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeviceSerialNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NetworkInterfaceDeviceIndex\":");
    try aws.json.writeValue(@TypeOf(input.network_interface_device_index), input.network_interface_device_index, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartConnectionOutput {
    var result: StartConnectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartConnectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
