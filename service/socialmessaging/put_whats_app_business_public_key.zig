const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutWhatsAppBusinessPublicKeyInput = struct {
    /// The PEM-encoded 2048-bit RSA public key to set. Mutually exclusive with
    /// `kmsKeyArn`.
    business_public_key: ?[]const u8 = null,

    /// The ARN of a customer managed asymmetric RSA key in Amazon Web Services KMS.
    /// Mutually exclusive with `businessPublicKey`.
    kms_key_arn: ?[]const u8 = null,

    /// The unique identifier of the phone number to associate with the business
    /// public key.
    origination_phone_number_id: []const u8,

    pub const json_field_names = .{
        .business_public_key = "businessPublicKey",
        .kms_key_arn = "kmsKeyArn",
        .origination_phone_number_id = "originationPhoneNumberId",
    };
};

pub const PutWhatsAppBusinessPublicKeyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutWhatsAppBusinessPublicKeyInput, options: CallOptions) !PutWhatsAppBusinessPublicKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutWhatsAppBusinessPublicKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/business-public-key";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.business_public_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"businessPublicKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"originationPhoneNumberId\":");
    try aws.json.writeValue(@TypeOf(input.origination_phone_number_id), input.origination_phone_number_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutWhatsAppBusinessPublicKeyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutWhatsAppBusinessPublicKeyOutput = .{};

    return result;
}
