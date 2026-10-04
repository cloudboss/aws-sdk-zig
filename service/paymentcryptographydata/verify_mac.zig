const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MacAttributes = @import("mac_attributes.zig").MacAttributes;

pub const VerifyMacInput = struct {
    /// The `keyARN` of the encryption key that Amazon Web Services Payment
    /// Cryptography uses to verify MAC data.
    key_identifier: []const u8,

    /// The MAC being verified.
    mac: []const u8,

    /// The length of the MAC.
    mac_length: ?i32 = null,

    /// The data on for which MAC is under verification. This value must be
    /// hexBinary.
    message_data: []const u8,

    /// The attributes and data values to use for MAC verification within Amazon Web
    /// Services Payment Cryptography.
    verification_attributes: MacAttributes,

    pub const json_field_names = .{
        .key_identifier = "KeyIdentifier",
        .mac = "Mac",
        .mac_length = "MacLength",
        .message_data = "MessageData",
        .verification_attributes = "VerificationAttributes",
    };
};

pub const VerifyMacOutput = struct {
    /// The `keyARN` of the encryption key that Amazon Web Services Payment
    /// Cryptography uses for MAC verification.
    key_arn: []const u8,

    /// The key check value (KCV) of the encryption key. The KCV is used to check if
    /// all parties holding a given key have the same key or to detect that a key
    /// has changed.
    ///
    /// Amazon Web Services Payment Cryptography computes the KCV according to the
    /// CMAC specification.
    key_check_value: []const u8,

    pub const json_field_names = .{
        .key_arn = "KeyArn",
        .key_check_value = "KeyCheckValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyMacInput, options: CallOptions) !VerifyMacOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "paymentcryptographydataplane", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyMacInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataplane.payment-cryptography", "Payment Cryptography Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/mac/verify";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"KeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.key_identifier), input.key_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Mac\":");
    try aws.json.writeValue(@TypeOf(input.mac), input.mac, allocator, &body_buf);
    has_prev = true;
    if (input.mac_length) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MacLength\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MessageData\":");
    try aws.json.writeValue(@TypeOf(input.message_data), input.message_data, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VerificationAttributes\":");
    try aws.json.writeValue(@TypeOf(input.verification_attributes), input.verification_attributes, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyMacOutput {
    const result: VerifyMacOutput = try aws.json.parseJsonObject(
        VerifyMacOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
