const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const As2805PekDerivationAttributes = @import("as_2805_pek_derivation_attributes.zig").As2805PekDerivationAttributes;
const DukptDerivationAttributes = @import("dukpt_derivation_attributes.zig").DukptDerivationAttributes;
const TranslationIsoFormats = @import("translation_iso_formats.zig").TranslationIsoFormats;
const WrappedKey = @import("wrapped_key.zig").WrappedKey;

pub const TranslatePinDataInput = struct {
    /// The encrypted PIN block data that Amazon Web Services Payment Cryptography
    /// translates.
    encrypted_pin_block: []const u8,

    /// The attributes and values to use for incoming AS2805 encryption key for PIN
    /// block translation.
    incoming_as_2805_attributes: ?As2805PekDerivationAttributes = null,

    /// The attributes and values to use for incoming DUKPT encryption key for PIN
    /// block translation.
    incoming_dukpt_attributes: ?DukptDerivationAttributes = null,

    /// The `keyARN` of the encryption key under which incoming PIN block data is
    /// encrypted. This key type can be PEK or BDK.
    ///
    /// For dynamic keys, it is the `keyARN` of KEK of the TR-31 wrapped PEK. For
    /// ECDH, it is the `keyARN` of the asymmetric ECC key.
    incoming_key_identifier: []const u8,

    /// The format of the incoming PIN block data for translation within Amazon Web
    /// Services Payment Cryptography.
    incoming_translation_attributes: TranslationIsoFormats,

    /// The WrappedKeyBlock containing the encryption key under which incoming PIN
    /// block data is encrypted.
    incoming_wrapped_key: ?WrappedKey = null,

    /// The attributes and values to use for outgoing DUKPT encryption key after PIN
    /// block translation.
    outgoing_dukpt_attributes: ?DukptDerivationAttributes = null,

    /// The `keyARN` of the encryption key for encrypting outgoing PIN block data.
    /// This key type can be PEK or BDK.
    ///
    /// For ECDH, it is the `keyARN` of the asymmetric ECC key.
    outgoing_key_identifier: []const u8,

    /// The format of the outgoing PIN block data after translation by Amazon Web
    /// Services Payment Cryptography.
    outgoing_translation_attributes: TranslationIsoFormats,

    /// The WrappedKeyBlock containing the encryption key for encrypting outgoing
    /// PIN block data.
    outgoing_wrapped_key: ?WrappedKey = null,

    pub const json_field_names = .{
        .encrypted_pin_block = "EncryptedPinBlock",
        .incoming_as_2805_attributes = "IncomingAs2805Attributes",
        .incoming_dukpt_attributes = "IncomingDukptAttributes",
        .incoming_key_identifier = "IncomingKeyIdentifier",
        .incoming_translation_attributes = "IncomingTranslationAttributes",
        .incoming_wrapped_key = "IncomingWrappedKey",
        .outgoing_dukpt_attributes = "OutgoingDukptAttributes",
        .outgoing_key_identifier = "OutgoingKeyIdentifier",
        .outgoing_translation_attributes = "OutgoingTranslationAttributes",
        .outgoing_wrapped_key = "OutgoingWrappedKey",
    };
};

pub const TranslatePinDataOutput = struct {
    /// The `keyARN` of the encryption key that Amazon Web Services Payment
    /// Cryptography uses to encrypt outgoing PIN block data after translation.
    key_arn: []const u8,

    /// The key check value (KCV) of the encryption key. The KCV is used to check if
    /// all parties holding a given key have the same key or to detect that a key
    /// has changed.
    ///
    /// Amazon Web Services Payment Cryptography computes the KCV according to the
    /// CMAC specification.
    key_check_value: []const u8,

    /// The outgoing encrypted PIN block data after translation.
    pin_block: []const u8,

    pub const json_field_names = .{
        .key_arn = "KeyArn",
        .key_check_value = "KeyCheckValue",
        .pin_block = "PinBlock",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TranslatePinDataInput, options: CallOptions) !TranslatePinDataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TranslatePinDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("paymentcryptographydata", "Payment Cryptography Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/pindata/translate";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EncryptedPinBlock\":");
    try aws.json.writeValue(@TypeOf(input.encrypted_pin_block), input.encrypted_pin_block, allocator, &body_buf);
    has_prev = true;
    if (input.incoming_as_2805_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncomingAs2805Attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.incoming_dukpt_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncomingDukptAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IncomingKeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.incoming_key_identifier), input.incoming_key_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IncomingTranslationAttributes\":");
    try aws.json.writeValue(@TypeOf(input.incoming_translation_attributes), input.incoming_translation_attributes, allocator, &body_buf);
    has_prev = true;
    if (input.incoming_wrapped_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncomingWrappedKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.outgoing_dukpt_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OutgoingDukptAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutgoingKeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.outgoing_key_identifier), input.outgoing_key_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutgoingTranslationAttributes\":");
    try aws.json.writeValue(@TypeOf(input.outgoing_translation_attributes), input.outgoing_translation_attributes, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TranslatePinDataOutput {
    var result: TranslatePinDataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(TranslatePinDataOutput, body, allocator);
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
