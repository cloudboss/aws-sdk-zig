const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Service = @import("service.zig").Service;
const IceServer = @import("ice_server.zig").IceServer;

pub const GetIceServerConfigInput = struct {
    /// The ARN of the signaling channel to be used for the peer-to-peer connection
    /// between
    /// configured peers.
    channel_arn: []const u8,

    /// Unique identifier for the viewer. Must be unique within the signaling
    /// channel.
    client_id: ?[]const u8 = null,

    /// Specifies the desired service. Currently, `TURN` is the only valid
    /// value.
    service: ?Service = null,

    /// An optional user ID to be associated with the credentials.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelARN",
        .client_id = "ClientId",
        .service = "Service",
        .username = "Username",
    };
};

pub const GetIceServerConfigOutput = struct {
    /// The list of ICE server information objects.
    ice_server_list: ?[]const IceServer = null,

    pub const json_field_names = .{
        .ice_server_list = "IceServerList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIceServerConfigInput, options: CallOptions) !GetIceServerConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisvideo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIceServerConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video Signaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/get-ice-server-config";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelARN\":");
    try aws.json.writeValue(@TypeOf(input.channel_arn), input.channel_arn, allocator, &body_buf);
    has_prev = true;
    if (input.client_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.service) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Service\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.username) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Username\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIceServerConfigOutput {
    var result: GetIceServerConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetIceServerConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
