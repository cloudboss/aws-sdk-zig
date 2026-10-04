const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WhatsAppCallSettings = @import("whats_app_call_settings.zig").WhatsAppCallSettings;

pub const UpdateLinkedWhatsAppBusinessAccountPhoneNumberInput = struct {
    /// The calling settings to apply to the phone number.
    call_settings: WhatsAppCallSettings,

    /// The unique identifier of the phone number to update. The phone number
    /// identifiers are formatted as
    /// `phone-number-id-01234567890123456789012345678901`.
    id: []const u8,

    pub const json_field_names = .{
        .call_settings = "callSettings",
        .id = "id",
    };
};

pub const UpdateLinkedWhatsAppBusinessAccountPhoneNumberOutput = struct {
    /// The unique identifier of the phone number that was updated.
    phone_number_id: []const u8,

    pub const json_field_names = .{
        .phone_number_id = "phoneNumberId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLinkedWhatsAppBusinessAccountPhoneNumberInput, options: CallOptions) !UpdateLinkedWhatsAppBusinessAccountPhoneNumberOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLinkedWhatsAppBusinessAccountPhoneNumberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/waba/phone";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "id=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"callSettings\":");
    try aws.json.writeValue(@TypeOf(input.call_settings), input.call_settings, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLinkedWhatsAppBusinessAccountPhoneNumberOutput {
    const result: UpdateLinkedWhatsAppBusinessAccountPhoneNumberOutput = try aws.json.parseJsonObject(
        UpdateLinkedWhatsAppBusinessAccountPhoneNumberOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
