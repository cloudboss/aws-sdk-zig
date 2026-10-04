const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SendWhatsAppCallEventInput = struct {
    /// The call event payload to send, as a JSON blob in the format defined by the
    /// Meta calling API.
    call_event: []const u8,

    /// The version of the Meta Graph API to use for the request.
    meta_api_version: []const u8,

    /// The unique identifier of the origination phone number for the call. The
    /// phone number identifiers are formatted as
    /// `phone-number-id-01234567890123456789012345678901`. Use
    /// `GetLinkedWhatsAppBusinessAccount` to find a phone number's ID.
    origination_phone_number_id: []const u8,

    pub const json_field_names = .{
        .call_event = "callEvent",
        .meta_api_version = "metaApiVersion",
        .origination_phone_number_id = "originationPhoneNumberId",
    };
};

pub const SendWhatsAppCallEventOutput = struct {
    /// The unique identifier that Meta assigns to the call.
    call_id: []const u8,

    pub const json_field_names = .{
        .call_id = "callId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendWhatsAppCallEventInput, options: CallOptions) !SendWhatsAppCallEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "social-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendWhatsAppCallEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/call/event";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"callEvent\":");
    try aws.json.writeValue(@TypeOf(input.call_event), input.call_event, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"metaApiVersion\":");
    try aws.json.writeValue(@TypeOf(input.meta_api_version), input.meta_api_version, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"originationPhoneNumberId\":");
    try aws.json.writeValue(@TypeOf(input.origination_phone_number_id), input.origination_phone_number_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendWhatsAppCallEventOutput {
    const result: SendWhatsAppCallEventOutput = try aws.json.parseJsonObject(
        SendWhatsAppCallEventOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
