const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Proxy = @import("proxy.zig").Proxy;

pub const PutVoiceConnectorProxyInput = struct {
    /// The default number of minutes allowed for proxy session.
    default_session_expiry_minutes: i32,

    /// When true, stops proxy sessions from being created on the specified Amazon
    /// Chime SDK Voice Connector.
    disabled: ?bool = null,

    /// The phone number to route calls to after a proxy session expires.
    fall_back_phone_number: ?[]const u8 = null,

    /// The countries for proxy phone numbers to be selected from.
    phone_number_pool_countries: []const []const u8,

    /// The Voice Connector ID.
    voice_connector_id: []const u8,

    pub const json_field_names = .{
        .default_session_expiry_minutes = "DefaultSessionExpiryMinutes",
        .disabled = "Disabled",
        .fall_back_phone_number = "FallBackPhoneNumber",
        .phone_number_pool_countries = "PhoneNumberPoolCountries",
        .voice_connector_id = "VoiceConnectorId",
    };
};

pub const PutVoiceConnectorProxyOutput = struct {
    /// The proxy configuration details.
    proxy: ?Proxy = null,

    pub const json_field_names = .{
        .proxy = "Proxy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutVoiceConnectorProxyInput, options: CallOptions) !PutVoiceConnectorProxyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutVoiceConnectorProxyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/voice-connectors/");
    try path_buf.appendSlice(allocator, input.voice_connector_id);
    try path_buf.appendSlice(allocator, "/programmable-numbers/proxy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DefaultSessionExpiryMinutes\":");
    try aws.json.writeValue(@TypeOf(input.default_session_expiry_minutes), input.default_session_expiry_minutes, allocator, &body_buf);
    has_prev = true;
    if (input.disabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Disabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fall_back_phone_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FallBackPhoneNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PhoneNumberPoolCountries\":");
    try aws.json.writeValue(@TypeOf(input.phone_number_pool_countries), input.phone_number_pool_countries, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutVoiceConnectorProxyOutput {
    const result: PutVoiceConnectorProxyOutput = try aws.json.parseJsonObject(
        PutVoiceConnectorProxyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
