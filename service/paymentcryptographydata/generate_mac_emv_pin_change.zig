const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateMacEmvPinChangeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataplane.payment-cryptography", "Payment Cryptography Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/macemvpinchange/generate";

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateMacEmvPinChangeOutput {
    const result: GenerateMacEmvPinChangeOutput = try aws.json.parseJsonObject(
        GenerateMacEmvPinChangeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
