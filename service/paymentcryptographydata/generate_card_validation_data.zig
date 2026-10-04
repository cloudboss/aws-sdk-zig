const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CardGenerationAttributes = @import("card_generation_attributes.zig").CardGenerationAttributes;

pub const GenerateCardValidationDataInput = struct {
    /// The algorithm for generating CVV or CSC values for the card within Amazon
    /// Web Services Payment Cryptography.
    generation_attributes: CardGenerationAttributes,

    /// The `keyARN` of the CVK encryption key that Amazon Web Services Payment
    /// Cryptography uses to generate card data.
    key_identifier: []const u8,

    /// The Primary Account Number (PAN), a unique identifier for a payment credit
    /// or debit card that associates the card with a specific account holder.
    primary_account_number: []const u8,

    /// The length of the CVV or CSC to be generated. The default value is 3.
    validation_data_length: ?i32 = null,

    pub const json_field_names = .{
        .generation_attributes = "GenerationAttributes",
        .key_identifier = "KeyIdentifier",
        .primary_account_number = "PrimaryAccountNumber",
        .validation_data_length = "ValidationDataLength",
    };
};

pub const GenerateCardValidationDataOutput = struct {
    /// The `keyARN` of the CVK encryption key that Amazon Web Services Payment
    /// Cryptography uses to generate CVV or CSC.
    key_arn: []const u8,

    /// The key check value (KCV) of the encryption key. The KCV is used to check if
    /// all parties holding a given key have the same key or to detect that a key
    /// has changed.
    ///
    /// Amazon Web Services Payment Cryptography computes the KCV according to the
    /// CMAC specification.
    key_check_value: []const u8,

    /// The CVV or CSC value that Amazon Web Services Payment Cryptography generates
    /// for the card.
    validation_data: []const u8,

    pub const json_field_names = .{
        .key_arn = "KeyArn",
        .key_check_value = "KeyCheckValue",
        .validation_data = "ValidationData",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateCardValidationDataInput, options: CallOptions) !GenerateCardValidationDataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateCardValidationDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataplane.payment-cryptography", "Payment Cryptography Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cardvalidationdata/generate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GenerationAttributes\":");
    try aws.json.writeValue(@TypeOf(input.generation_attributes), input.generation_attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"KeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.key_identifier), input.key_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PrimaryAccountNumber\":");
    try aws.json.writeValue(@TypeOf(input.primary_account_number), input.primary_account_number, allocator, &body_buf);
    has_prev = true;
    if (input.validation_data_length) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ValidationDataLength\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateCardValidationDataOutput {
    var result: GenerateCardValidationDataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GenerateCardValidationDataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
