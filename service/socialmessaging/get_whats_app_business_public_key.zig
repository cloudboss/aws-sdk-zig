const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetWhatsAppBusinessPublicKeyInput = struct {
    /// The unique identifier of the phone number whose business public key to
    /// retrieve.
    origination_phone_number_id: []const u8,

    pub const json_field_names = .{
        .origination_phone_number_id = "originationPhoneNumberId",
    };
};

pub const GetWhatsAppBusinessPublicKeyOutput = struct {
    /// The stored PEM-encoded 2048-bit RSA public key.
    business_public_key: ?[]const u8 = null,

    /// The signature status of the stored business public key. Valid values are
    /// VALID and MISMATCH.
    business_public_key_signature_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .business_public_key = "businessPublicKey",
        .business_public_key_signature_status = "businessPublicKeySignatureStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWhatsAppBusinessPublicKeyInput, options: CallOptions) !GetWhatsAppBusinessPublicKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWhatsAppBusinessPublicKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/business-public-key";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "originationPhoneNumberId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.origination_phone_number_id);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWhatsAppBusinessPublicKeyOutput {
    const result: GetWhatsAppBusinessPublicKeyOutput = try aws.json.parseJsonObject(
        GetWhatsAppBusinessPublicKeyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
