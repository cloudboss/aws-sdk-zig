const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CryptogramAuthResponse = @import("cryptogram_auth_response.zig").CryptogramAuthResponse;
const MajorKeyDerivationMode = @import("major_key_derivation_mode.zig").MajorKeyDerivationMode;
const SessionKeyDerivation = @import("session_key_derivation.zig").SessionKeyDerivation;

pub const VerifyAuthRequestCryptogramInput = struct {
    /// The auth request cryptogram imported into Amazon Web Services Payment
    /// Cryptography for ARQC verification using a major encryption key and
    /// transaction data.
    auth_request_cryptogram: []const u8,

    /// The attributes and values for auth request cryptogram verification. These
    /// parameters are required in case using ARPC Method 1 or Method 2 for ARQC
    /// verification.
    auth_response_attributes: ?CryptogramAuthResponse = null,

    /// The `keyARN` of the major encryption key that Amazon Web Services Payment
    /// Cryptography uses for ARQC verification.
    key_identifier: []const u8,

    /// The method to use when deriving the major encryption key for ARQC
    /// verification within Amazon Web Services Payment Cryptography. The same key
    /// derivation mode was used for ARQC generation outside of Amazon Web Services
    /// Payment Cryptography.
    major_key_derivation_mode: MajorKeyDerivationMode,

    /// The attributes and values to use for deriving a session key for ARQC
    /// verification within Amazon Web Services Payment Cryptography. The same
    /// attributes were used for ARQC generation outside of Amazon Web Services
    /// Payment Cryptography.
    session_key_derivation_attributes: SessionKeyDerivation,

    /// The transaction data that Amazon Web Services Payment Cryptography uses for
    /// ARQC verification. The same transaction is used for ARQC generation outside
    /// of Amazon Web Services Payment Cryptography.
    transaction_data: []const u8,

    pub const json_field_names = .{
        .auth_request_cryptogram = "AuthRequestCryptogram",
        .auth_response_attributes = "AuthResponseAttributes",
        .key_identifier = "KeyIdentifier",
        .major_key_derivation_mode = "MajorKeyDerivationMode",
        .session_key_derivation_attributes = "SessionKeyDerivationAttributes",
        .transaction_data = "TransactionData",
    };
};

pub const VerifyAuthRequestCryptogramOutput = struct {
    /// The result for ARQC verification or ARPC generation within Amazon Web
    /// Services Payment Cryptography.
    auth_response_value: ?[]const u8 = null,

    /// The `keyARN` of the major encryption key that Amazon Web Services Payment
    /// Cryptography uses for ARQC verification.
    key_arn: []const u8,

    /// The key check value (KCV) of the encryption key. The KCV is used to check if
    /// all parties holding a given key have the same key or to detect that a key
    /// has changed.
    ///
    /// Amazon Web Services Payment Cryptography computes the KCV according to the
    /// CMAC specification.
    key_check_value: []const u8,

    pub const json_field_names = .{
        .auth_response_value = "AuthResponseValue",
        .key_arn = "KeyArn",
        .key_check_value = "KeyCheckValue",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyAuthRequestCryptogramInput, options: CallOptions) !VerifyAuthRequestCryptogramOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyAuthRequestCryptogramInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataplane.payment-cryptography", "Payment Cryptography Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/cryptogram/verify";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AuthRequestCryptogram\":");
    try aws.json.writeValue(@TypeOf(input.auth_request_cryptogram), input.auth_request_cryptogram, allocator, &body_buf);
    has_prev = true;
    if (input.auth_response_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AuthResponseAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"KeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.key_identifier), input.key_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MajorKeyDerivationMode\":");
    try aws.json.writeValue(@TypeOf(input.major_key_derivation_mode), input.major_key_derivation_mode, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SessionKeyDerivationAttributes\":");
    try aws.json.writeValue(@TypeOf(input.session_key_derivation_attributes), input.session_key_derivation_attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TransactionData\":");
    try aws.json.writeValue(@TypeOf(input.transaction_data), input.transaction_data, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyAuthRequestCryptogramOutput {
    var result: VerifyAuthRequestCryptogramOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(VerifyAuthRequestCryptogramOutput, body, allocator);
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
