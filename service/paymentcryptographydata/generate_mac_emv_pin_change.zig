const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DerivationMethodAttributes = @import("derivation_method_attributes.zig").DerivationMethodAttributes;
const PinBlockFormatForEmvPinChange = @import("pin_block_format_for_emv_pin_change.zig").PinBlockFormatForEmvPinChange;
const VisaAmexDerivationOutputs = @import("visa_amex_derivation_outputs.zig").VisaAmexDerivationOutputs;

pub const GenerateMacEmvPinChangeInput = struct {
    /// The attributes and data values to derive payment card specific
    /// confidentiality and integrity keys.
    derivation_method_attributes: DerivationMethodAttributes,

    /// The message data is the APDU command from the card reader or terminal. The
    /// target encrypted PIN block, after translation to ISO2 format, is appended to
    /// this message data to generate an issuer script response.
    message_data: []const u8,

    /// The incoming new encrypted PIN block data for offline pin change on an EMV
    /// card.
    new_encrypted_pin_block: []const u8,

    /// The `keyARN` of the PEK protecting the incoming new encrypted PIN block.
    new_pin_pek_identifier: []const u8,

    /// The PIN encoding format of the incoming new encrypted PIN block as specified
    /// in ISO 9564.
    pin_block_format: PinBlockFormatForEmvPinChange,

    /// The `keyARN` of the issuer master key (IMK-SMC) used to protect the PIN
    /// block data in the issuer script response.
    secure_messaging_confidentiality_key_identifier: []const u8,

    /// The `keyARN` of the issuer master key (IMK-SMI) used to authenticate the
    /// issuer script response.
    secure_messaging_integrity_key_identifier: []const u8,

    pub const json_field_names = .{
        .derivation_method_attributes = "DerivationMethodAttributes",
        .message_data = "MessageData",
        .new_encrypted_pin_block = "NewEncryptedPinBlock",
        .new_pin_pek_identifier = "NewPinPekIdentifier",
        .pin_block_format = "PinBlockFormat",
        .secure_messaging_confidentiality_key_identifier = "SecureMessagingConfidentialityKeyIdentifier",
        .secure_messaging_integrity_key_identifier = "SecureMessagingIntegrityKeyIdentifier",
    };
};

pub const GenerateMacEmvPinChangeOutput = struct {
    /// Returns the incoming new encrpted PIN block.
    encrypted_pin_block: []const u8,

    /// Returns the mac of the issuer script containing message data and appended
    /// target encrypted pin block in ISO2 format.
    mac: []const u8,

    /// Returns the `keyArn` of the PEK protecting the incoming new encrypted PIN
    /// block.
    new_pin_pek_arn: []const u8,

    /// The key check value (KCV) of the PEK uprotecting the incoming new encrypted
    /// PIN block.
    new_pin_pek_key_check_value: []const u8,

    /// Returns the `keyArn` of the IMK-SMC used by the operation.
    secure_messaging_confidentiality_key_arn: []const u8,

    /// The key check value (KCV) of the SMC issuer master key used by the
    /// operation.
    secure_messaging_confidentiality_key_check_value: []const u8,

    /// Returns the `keyArn` of the IMK-SMI used by the operation.
    secure_messaging_integrity_key_arn: []const u8,

    /// The key check value (KCV) of the SMI issuer master key used by the
    /// operation.
    secure_messaging_integrity_key_check_value: []const u8,

    /// The attribute values used for Amex and Visa derivation methods.
    visa_amex_derivation_outputs: ?VisaAmexDerivationOutputs = null,

    pub const json_field_names = .{
        .encrypted_pin_block = "EncryptedPinBlock",
        .mac = "Mac",
        .new_pin_pek_arn = "NewPinPekArn",
        .new_pin_pek_key_check_value = "NewPinPekKeyCheckValue",
        .secure_messaging_confidentiality_key_arn = "SecureMessagingConfidentialityKeyArn",
        .secure_messaging_confidentiality_key_check_value = "SecureMessagingConfidentialityKeyCheckValue",
        .secure_messaging_integrity_key_arn = "SecureMessagingIntegrityKeyArn",
        .secure_messaging_integrity_key_check_value = "SecureMessagingIntegrityKeyCheckValue",
        .visa_amex_derivation_outputs = "VisaAmexDerivationOutputs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateMacEmvPinChangeInput, options: CallOptions) !GenerateMacEmvPinChangeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateMacEmvPinChangeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataplane.payment-cryptography", "Payment Cryptography Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/macemvpinchange/generate";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DerivationMethodAttributes\":");
    try aws.json.writeValue(@TypeOf(input.derivation_method_attributes), input.derivation_method_attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MessageData\":");
    try aws.json.writeValue(@TypeOf(input.message_data), input.message_data, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NewEncryptedPinBlock\":");
    try aws.json.writeValue(@TypeOf(input.new_encrypted_pin_block), input.new_encrypted_pin_block, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NewPinPekIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.new_pin_pek_identifier), input.new_pin_pek_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PinBlockFormat\":");
    try aws.json.writeValue(@TypeOf(input.pin_block_format), input.pin_block_format, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecureMessagingConfidentialityKeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.secure_messaging_confidentiality_key_identifier), input.secure_messaging_confidentiality_key_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecureMessagingIntegrityKeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.secure_messaging_integrity_key_identifier), input.secure_messaging_integrity_key_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateMacEmvPinChangeOutput {
    var result: GenerateMacEmvPinChangeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GenerateMacEmvPinChangeOutput, body, allocator);
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
