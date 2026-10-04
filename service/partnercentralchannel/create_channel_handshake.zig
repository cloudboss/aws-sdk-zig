const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HandshakeType = @import("handshake_type.zig").HandshakeType;
const ChannelHandshakePayload = @import("channel_handshake_payload.zig").ChannelHandshakePayload;
const Tag = @import("tag.zig").Tag;
const CreateChannelHandshakeDetail = @import("create_channel_handshake_detail.zig").CreateChannelHandshakeDetail;

pub const CreateChannelHandshakeInput = struct {
    /// The identifier of the resource associated with this handshake.
    associated_resource_identifier: []const u8,

    /// The catalog identifier for the handshake request.
    catalog: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The type of handshake to create (e.g., start service period, revoke service
    /// period).
    handshake_type: HandshakeType,

    /// The payload containing specific details for the handshake type.
    payload: ?ChannelHandshakePayload = null,

    /// Key-value pairs to associate with the channel handshake.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .associated_resource_identifier = "associatedResourceIdentifier",
        .catalog = "catalog",
        .client_token = "clientToken",
        .handshake_type = "handshakeType",
        .payload = "payload",
        .tags = "tags",
    };
};

pub const CreateChannelHandshakeOutput = struct {
    /// Details of the created channel handshake.
    channel_handshake_detail: ?CreateChannelHandshakeDetail = null,

    pub const json_field_names = .{
        .channel_handshake_detail = "channelHandshakeDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelHandshakeInput, options: CallOptions) !CreateChannelHandshakeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChannelHandshakeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-channel", "PartnerCentral Channel", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralChannel.CreateChannelHandshake");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChannelHandshakeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateChannelHandshakeOutput, body, allocator);
}
