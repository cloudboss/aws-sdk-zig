const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SendWhatsAppMessageInput = struct {
    /// The message to send through WhatsApp. The length is in KB. The message field
    /// passes through a WhatsApp
    /// Message object, see
    /// [Messages](https://developers.facebook.com/docs/whatsapp/cloud-api/reference/messages) in the *WhatsApp Business Platform Cloud API
    /// Reference*.
    message: []const u8,

    /// The API version for the request formatted as `v{VersionNumber}`. For a list
    /// of supported API versions and Amazon Web Services Regions, see [
    /// *Amazon Web Services End User Messaging Social API* Service
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/end-user-messaging.html) in the *Amazon Web Services General Reference*.
    meta_api_version: []const u8,

    /// The ID of the phone number used to send the WhatsApp message. If you are
    /// sending a media
    /// file only the `originationPhoneNumberId` used to upload the file can be
    /// used.
    /// Phone number identifiers are formatted as
    /// `phone-number-id-01234567890123456789012345678901`. Use
    /// [GetLinkedWhatsAppBusinessAccount](https://docs.aws.amazon.com/social-messaging/latest/APIReference/API_GetLinkedWhatsAppBusinessAccount.html) to find a phone number's
    /// id.
    origination_phone_number_id: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .meta_api_version = "metaApiVersion",
        .origination_phone_number_id = "originationPhoneNumberId",
    };
};

pub const SendWhatsAppMessageOutput = struct {
    /// The unique identifier of the message.
    message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_id = "messageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendWhatsAppMessageInput, options: CallOptions) !SendWhatsAppMessageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendWhatsAppMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/send";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"message\":");
    try aws.json.writeValue(@TypeOf(input.message), input.message, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendWhatsAppMessageOutput {
    var result: SendWhatsAppMessageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SendWhatsAppMessageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
