const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "paymentcryptographydata");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ReEncryptDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("paymentcryptographydata", "Payment Cryptography Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/keys/");
    try path_buf.appendSlice(allocator, input.incoming_key_identifier);
    try path_buf.appendSlice(allocator, "/reencrypt");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VerificationFailedException")) {
        return .{ .arena = arena, .kind = .{ .verification_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
