const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteWhatsAppMessageMediaInput = struct {
    /// The unique identifier of the media file to delete. Use the `mediaId`
    /// returned from
    /// [PostWhatsAppMessageMedia](https://console.aws.amazon.com/social-messaging/latest/APIReference/API_PostWhatsAppMessageMedia.html).
    media_id: []const u8,

    /// The unique identifier of the originating phone number associated with the
    /// media. Phone
    /// number identifiers are formatted as
    /// `phone-number-id-01234567890123456789012345678901`. Use
    /// [GetLinkedWhatsAppBusinessAccount](https://docs.aws.amazon.com/social-messaging/latest/APIReference/API_GetLinkedWhatsAppBusinessAccount.html) to find a phone number's
    /// id.
    origination_phone_number_id: []const u8,

    pub const json_field_names = .{
        .media_id = "mediaId",
        .origination_phone_number_id = "originationPhoneNumberId",
    };
};

pub const DeleteWhatsAppMessageMediaOutput = struct {
    /// Success indicator for deleting the media file.
    success: ?bool = null,

    pub const json_field_names = .{
        .success = "success",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteWhatsAppMessageMediaInput, options: CallOptions) !DeleteWhatsAppMessageMediaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteWhatsAppMessageMediaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/media";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "mediaId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.media_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "originationPhoneNumberId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.origination_phone_number_id);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteWhatsAppMessageMediaOutput {
    const result: DeleteWhatsAppMessageMediaOutput = try aws.json.parseJsonObject(
        DeleteWhatsAppMessageMediaOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
