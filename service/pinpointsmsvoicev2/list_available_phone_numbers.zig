const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NumberCapability = @import("number_capability.zig").NumberCapability;
const NumberPreferenceItem = @import("number_preference_item.zig").NumberPreferenceItem;
const SearchableNumberType = @import("searchable_number_type.zig").SearchableNumberType;

pub const ListAvailablePhoneNumbersInput = struct {
    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region in which to search for available phone numbers. This operation
    /// currently supports only `US`.
    iso_country_code: []const u8,

    /// The maximum number of results to return per page. If you don't specify a
    /// value, the default is 10.
    max_results: ?i32 = null,

    /// The token returned from a previous request to retrieve the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The capabilities to filter by, such as SMS. Only phone numbers that support
    /// all of the specified capabilities are returned.
    number_capabilities: []const NumberCapability,

    /// An optional selection preference used to return only phone numbers that
    /// match a specific digit pattern, such as numbers that start with, end with,
    /// or contain a particular sequence. You can specify at most one preference.
    /// Number preferences apply only to `TEN_DLC` numbers in the `US`.
    number_preference: ?[]const NumberPreferenceItem = null,

    /// The type of phone number to search for.
    number_type: SearchableNumberType,

    /// The registration associated with the request. A registration is required for
    /// regulated number types. You can specify either:
    ///
    /// * The unique identifier of the registration.
    /// * The Amazon Resource Name (ARN) of the registration.
    registration_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .iso_country_code = "IsoCountryCode",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .number_capabilities = "NumberCapabilities",
        .number_preference = "NumberPreference",
        .number_type = "NumberType",
        .registration_id = "RegistrationId",
    };
};

pub const ListAvailablePhoneNumbersOutput = struct {
    /// An array of phone numbers, in E.164 format, that are available to request
    /// based on the specified filters.
    available_phone_numbers: ?[]const []const u8 = null,

    /// The token to include in the next request to retrieve the next page of
    /// results. This value is null when there are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .available_phone_numbers = "AvailablePhoneNumbers",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAvailablePhoneNumbersInput, options: CallOptions) !ListAvailablePhoneNumbersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAvailablePhoneNumbersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.ListAvailablePhoneNumbers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAvailablePhoneNumbersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListAvailablePhoneNumbersOutput, body, allocator);
}
