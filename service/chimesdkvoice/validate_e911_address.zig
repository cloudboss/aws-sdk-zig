const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Address = @import("address.zig").Address;
const CandidateAddress = @import("candidate_address.zig").CandidateAddress;

pub const ValidateE911AddressInput = struct {
    /// The AWS account ID.
    aws_account_id: []const u8,

    /// The address city, such as `Portland`.
    city: []const u8,

    /// The country in the address being validated as two-letter country code in ISO
    /// 3166-1
    /// alpha-2 format, such as `US`. For more information, see [ISO 3166-1
    /// alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) in
    /// Wikipedia.
    country: []const u8,

    /// The dress postal code, such `04352`.
    postal_code: []const u8,

    /// The address state, such as `ME`.
    state: []const u8,

    /// The address street information, such as `8th Avenue`.
    street_info: []const u8,

    /// The address street number, such as `200` or `2121`.
    street_number: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .city = "City",
        .country = "Country",
        .postal_code = "PostalCode",
        .state = "State",
        .street_info = "StreetInfo",
        .street_number = "StreetNumber",
    };
};

pub const ValidateE911AddressOutput = struct {
    /// The validated address.
    address: ?Address = null,

    /// The ID that represents the address.
    address_external_id: ?[]const u8 = null,

    /// The list of address suggestions..
    candidate_address_list: ?[]const CandidateAddress = null,

    /// Number indicating the result of address validation.
    ///
    /// Each possible result is defined as follows:
    ///
    /// * `0` - Address validation succeeded.
    ///
    /// * `1` - Address validation succeeded. The address was a close enough
    /// match and has been corrected as part of the address object.
    ///
    /// * `2` - Address validation failed. You should re-submit the validation
    /// request with candidates from the `CandidateAddressList` result, if it's a
    /// close match.
    validation_result: ?i32 = null,

    pub const json_field_names = .{
        .address = "Address",
        .address_external_id = "AddressExternalId",
        .candidate_address_list = "CandidateAddressList",
        .validation_result = "ValidationResult",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateE911AddressInput, options: CallOptions) !ValidateE911AddressOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidateE911AddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/emergency-calling/address";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AwsAccountId\":");
    try aws.json.writeValue(@TypeOf(input.aws_account_id), input.aws_account_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"City\":");
    try aws.json.writeValue(@TypeOf(input.city), input.city, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Country\":");
    try aws.json.writeValue(@TypeOf(input.country), input.country, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PostalCode\":");
    try aws.json.writeValue(@TypeOf(input.postal_code), input.postal_code, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"State\":");
    try aws.json.writeValue(@TypeOf(input.state), input.state, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StreetInfo\":");
    try aws.json.writeValue(@TypeOf(input.street_info), input.street_info, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StreetNumber\":");
    try aws.json.writeValue(@TypeOf(input.street_number), input.street_number, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidateE911AddressOutput {
    var result: ValidateE911AddressOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ValidateE911AddressOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
