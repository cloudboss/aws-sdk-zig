const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Capability = @import("capability.zig").Capability;
const ProxySession = @import("proxy_session.zig").ProxySession;

pub const UpdateProxySessionInput = struct {
    /// The proxy session capabilities.
    capabilities: []const Capability,

    /// The number of minutes allowed for the proxy session.
    expiry_minutes: ?i32 = null,

    /// The proxy session ID.
    proxy_session_id: []const u8,

    /// The Voice Connector ID.
    voice_connector_id: []const u8,

    pub const json_field_names = .{
        .capabilities = "Capabilities",
        .expiry_minutes = "ExpiryMinutes",
        .proxy_session_id = "ProxySessionId",
        .voice_connector_id = "VoiceConnectorId",
    };
};

pub const UpdateProxySessionOutput = struct {
    /// The updated proxy session details.
    proxy_session: ?ProxySession = null,

    pub const json_field_names = .{
        .proxy_session = "ProxySession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProxySessionInput, options: CallOptions) !UpdateProxySessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProxySessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/voice-connectors/");
    try path_buf.appendSlice(allocator, input.voice_connector_id);
    try path_buf.appendSlice(allocator, "/proxy-sessions/");
    try path_buf.appendSlice(allocator, input.proxy_session_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Capabilities\":");
    try aws.json.writeValue(@TypeOf(input.capabilities), input.capabilities, allocator, &body_buf);
    has_prev = true;
    if (input.expiry_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExpiryMinutes\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProxySessionOutput {
    const result: UpdateProxySessionOutput = try aws.json.parseJsonObject(
        UpdateProxySessionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
