const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WirelessMetadata = @import("wireless_metadata.zig").WirelessMetadata;

pub const SendDataToWirelessDeviceInput = struct {
    /// The ID of the wireless device to receive the data.
    id: []const u8,

    payload_data: []const u8,

    /// The transmit mode to use to send data to the wireless device. Can be: `0`
    /// for UM (unacknowledge mode) or `1` for AM (acknowledge mode).
    transmit_mode: i32,

    /// Metadata about the message request.
    wireless_metadata: ?WirelessMetadata = null,

    pub const json_field_names = .{
        .id = "Id",
        .payload_data = "PayloadData",
        .transmit_mode = "TransmitMode",
        .wireless_metadata = "WirelessMetadata",
    };
};

pub const SendDataToWirelessDeviceOutput = struct {
    /// The ID of the message sent to the wireless device.
    message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_id = "MessageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendDataToWirelessDeviceInput, options: CallOptions) !SendDataToWirelessDeviceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendDataToWirelessDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/wireless-devices/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/data");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PayloadData\":");
    try aws.json.writeValue(@TypeOf(input.payload_data), input.payload_data, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TransmitMode\":");
    try aws.json.writeValue(@TypeOf(input.transmit_mode), input.transmit_mode, allocator, &body_buf);
    has_prev = true;
    if (input.wireless_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WirelessMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendDataToWirelessDeviceOutput {
    const result: SendDataToWirelessDeviceOutput = try aws.json.parseJsonObject(
        SendDataToWirelessDeviceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
