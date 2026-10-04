const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkType = @import("network_type.zig").NetworkType;
const MessagingSessionEndpoint = @import("messaging_session_endpoint.zig").MessagingSessionEndpoint;

pub const GetMessagingSessionEndpointInput = struct {
    /// The type of network for the messaging session endpoint. Either IPv4 only or
    /// dual-stack (IPv4 and IPv6).
    network_type: ?NetworkType = null,

    pub const json_field_names = .{
        .network_type = "NetworkType",
    };
};

pub const GetMessagingSessionEndpointOutput = struct {
    /// The endpoint returned in the response.
    endpoint: ?MessagingSessionEndpoint = null,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMessagingSessionEndpointInput, options: CallOptions) !GetMessagingSessionEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMessagingSessionEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/endpoints/messaging-session";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.network_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "network-type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMessagingSessionEndpointOutput {
    var result: GetMessagingSessionEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMessagingSessionEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
