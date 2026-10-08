const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WirelessDeviceType = @import("wireless_device_type.zig").WirelessDeviceType;

pub const DeleteQueuedMessagesInput = struct {
    /// The ID of a given wireless device for which downlink messages will be
    /// deleted.
    id: []const u8,

    /// If message ID is `"*"`, it cleares the entire downlink queue for a given
    /// device, specified by the wireless device ID. Otherwise, the downlink message
    /// with the
    /// specified message ID will be deleted.
    message_id: []const u8,

    /// The wireless device type, which can be either Sidewalk or LoRaWAN.
    wireless_device_type: ?WirelessDeviceType = null,

    pub const json_field_names = .{
        .id = "Id",
        .message_id = "MessageId",
        .wireless_device_type = "WirelessDeviceType",
    };
};

pub const DeleteQueuedMessagesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteQueuedMessagesInput, options: CallOptions) !DeleteQueuedMessagesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteQueuedMessagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/wireless-devices/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/data");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "messageId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.message_id);
    query_has_prev = true;
    if (input.wireless_device_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "WirelessDeviceType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteQueuedMessagesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteQueuedMessagesOutput = .{};

    return result;
}
