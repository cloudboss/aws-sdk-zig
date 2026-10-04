const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReEncryptionAttributes = @import("re_encryption_attributes.zig").ReEncryptionAttributes;
const WrappedKey = @import("wrapped_key.zig").WrappedKey;

pub const ReEncryptDataInput = struct {
    /// Ciphertext to be encrypted. The minimum allowed length is 16 bytes and
    /// maximum allowed length is 4096 bytes.
    cipher_text: []const u8,

    /// The attributes and values for incoming ciphertext.
    incoming_encryption_attributes: ReEncryptionAttributes,

    /// The `keyARN` of the encryption key of incoming ciphertext data.
    ///
    /// When a WrappedKeyBlock is provided, this value will be the identifier to the
    /// key wrapping key. Otherwise, it is the key identifier used to perform the
    /// operation.
    incoming_key_identifier: []const u8,

    /// The WrappedKeyBlock containing the encryption key of incoming ciphertext
    /// data.
    incoming_wrapped_key: ?WrappedKey = null,

    /// The attributes and values for outgoing ciphertext data after encryption by
    /// Amazon Web Services Payment Cryptography.
    outgoing_encryption_attributes: ReEncryptionAttributes,

    /// The `keyARN` of the encryption key of outgoing ciphertext data after
    /// encryption by Amazon Web Services Payment Cryptography.
    outgoing_key_identifier: []const u8,

    /// The WrappedKeyBlock containing the encryption key of outgoing ciphertext
    /// data after encryption by Amazon Web Services Payment Cryptography.
    outgoing_wrapped_key: ?WrappedKey = null,

    pub const json_field_names = .{
        .cipher_text = "CipherText",
        .incoming_encryption_attributes = "IncomingEncryptionAttributes",
        .incoming_key_identifier = "IncomingKeyIdentifier",
        .incoming_wrapped_key = "IncomingWrappedKey",
        .outgoing_encryption_attributes = "OutgoingEncryptionAttributes",
        .outgoing_key_identifier = "OutgoingKeyIdentifier",
        .outgoing_wrapped_key = "OutgoingWrappedKey",
    };
};

pub const ReEncryptDataOutput = struct {
    /// The encrypted ciphertext.
    cipher_text: []const u8,

    /// The keyARN (Amazon Resource Name) of the encryption key that Amazon Web
    /// Services Payment Cryptography uses for plaintext encryption.
    key_arn: []const u8,

    /// The key check value (KCV) of the encryption key. The KCV is used to check if
    /// all parties holding a given key have the same key or to detect that a key
    /// has changed.
    ///
    /// Amazon Web Services Payment Cryptography computes the KCV according to the
    /// CMAC specification.
    key_check_value: []const u8,

    pub const json_field_names = .{
        .cipher_text = "CipherText",
        .key_arn = "KeyArn",
        .key_check_value = "KeyCheckValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReEncryptDataInput, options: CallOptions) !ReEncryptDataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ReEncryptDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataplane.payment-cryptography", "Payment Cryptography Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/keys/");
    try path_buf.appendSlice(allocator, input.incoming_key_identifier);
    try path_buf.appendSlice(allocator, "/reencrypt");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CipherText\":");
    try aws.json.writeValue(@TypeOf(input.cipher_text), input.cipher_text, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IncomingEncryptionAttributes\":");
    try aws.json.writeValue(@TypeOf(input.incoming_encryption_attributes), input.incoming_encryption_attributes, allocator, &body_buf);
    has_prev = true;
    if (input.incoming_wrapped_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncomingWrappedKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutgoingEncryptionAttributes\":");
    try aws.json.writeValue(@TypeOf(input.outgoing_encryption_attributes), input.outgoing_encryption_attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutgoingKeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.outgoing_key_identifier), input.outgoing_key_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.outgoing_wrapped_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OutgoingWrappedKey\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReEncryptDataOutput {
    var result: ReEncryptDataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ReEncryptDataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
