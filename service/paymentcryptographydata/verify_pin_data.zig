const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DukptAttributes = @import("dukpt_attributes.zig").DukptAttributes;
const WrappedKey = @import("wrapped_key.zig").WrappedKey;
const PinBlockFormatForPinData = @import("pin_block_format_for_pin_data.zig").PinBlockFormatForPinData;
const PinVerificationAttributes = @import("pin_verification_attributes.zig").PinVerificationAttributes;

pub const VerifyPinDataInput = struct {
    /// The attributes and values for the DUKPT encrypted PIN block data.
    dukpt_attributes: ?DukptAttributes = null,

    /// The encrypted PIN block data that Amazon Web Services Payment Cryptography
    /// verifies.
    encrypted_pin_block: []const u8,

    /// The `keyARN` of the encryption key under which the PIN block data is
    /// encrypted. This key type can be PEK or BDK.
    encryption_key_identifier: []const u8,

    encryption_wrapped_key: ?WrappedKey = null,

    /// The PIN encoding format for pin data generation as specified in ISO 9564.
    /// Amazon Web Services Payment Cryptography supports `ISO_Format_0` and
    /// `ISO_Format_3`.
    ///
    /// The `ISO_Format_0` PIN block format is equivalent to the ANSI X9.8, VISA-1,
    /// and ECI-1 PIN block formats. It is similar to a VISA-4 PIN block format. It
    /// supports a PIN from 4 to 12 digits in length.
    ///
    /// The `ISO_Format_3` PIN block format is the same as `ISO_Format_0` except
    /// that the fill digits are random values from 10 to 15.
    pin_block_format: PinBlockFormatForPinData,

    /// The length of PIN being verified.
    pin_data_length: ?i32 = null,

    /// The Primary Account Number (PAN), a unique identifier for a payment credit
    /// or debit card that associates the card with a specific account holder.
    primary_account_number: ?[]const u8 = null,

    /// The attributes and values for PIN data verification.
    verification_attributes: PinVerificationAttributes,

    /// The `keyARN` of the PIN verification key.
    verification_key_identifier: []const u8,

    pub const json_field_names = .{
        .dukpt_attributes = "DukptAttributes",
        .encrypted_pin_block = "EncryptedPinBlock",
        .encryption_key_identifier = "EncryptionKeyIdentifier",
        .encryption_wrapped_key = "EncryptionWrappedKey",
        .pin_block_format = "PinBlockFormat",
        .pin_data_length = "PinDataLength",
        .primary_account_number = "PrimaryAccountNumber",
        .verification_attributes = "VerificationAttributes",
        .verification_key_identifier = "VerificationKeyIdentifier",
    };
};

pub const VerifyPinDataOutput = struct {
    /// The `keyARN` of the PEK that Amazon Web Services Payment Cryptography uses
    /// for encrypted pin block generation.
    encryption_key_arn: []const u8,

    /// The key check value (KCV) of the encryption key. The KCV is used to check if
    /// all parties holding a given key have the same key or to detect that a key
    /// has changed.
    ///
    /// Amazon Web Services Payment Cryptography computes the KCV according to the
    /// CMAC specification.
    encryption_key_check_value: []const u8,

    /// The `keyARN` of the PIN encryption key that Amazon Web Services Payment
    /// Cryptography uses for PIN or PIN Offset verification.
    verification_key_arn: []const u8,

    /// The key check value (KCV) of the encryption key. The KCV is used to check if
    /// all parties holding a given key have the same key or to detect that a key
    /// has changed.
    ///
    /// Amazon Web Services Payment Cryptography computes the KCV according to the
    /// CMAC specification.
    verification_key_check_value: []const u8,

    pub const json_field_names = .{
        .encryption_key_arn = "EncryptionKeyArn",
        .encryption_key_check_value = "EncryptionKeyCheckValue",
        .verification_key_arn = "VerificationKeyArn",
        .verification_key_check_value = "VerificationKeyCheckValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyPinDataInput, options: CallOptions) !VerifyPinDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "paymentcryptographydataplane");

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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyPinDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataplane.payment-cryptography", "Payment Cryptography Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/pindata/verify";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dukpt_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DukptAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EncryptedPinBlock\":");
    try aws.json.writeValue(@TypeOf(input.encrypted_pin_block), input.encrypted_pin_block, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EncryptionKeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.encryption_key_identifier), input.encryption_key_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.encryption_wrapped_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionWrappedKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PinBlockFormat\":");
    try aws.json.writeValue(@TypeOf(input.pin_block_format), input.pin_block_format, allocator, &body_buf);
    has_prev = true;
    if (input.pin_data_length) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PinDataLength\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.primary_account_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PrimaryAccountNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VerificationAttributes\":");
    try aws.json.writeValue(@TypeOf(input.verification_attributes), input.verification_attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VerificationKeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.verification_key_identifier), input.verification_key_identifier, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyPinDataOutput {
    var result: VerifyPinDataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(VerifyPinDataOutput, body, allocator);
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
