const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;

pub const CarrierLookupInput = struct {
    /// The phone number that you want to retrieve information about. You can
    /// provide the phone number in various formats including special characters
    /// such as parentheses, brackets, spaces, hyphens, periods, and commas. The
    /// service automatically converts the input to E164 format for processing.
    phone_number: []const u8,

    pub const json_field_names = .{
        .phone_number = "PhoneNumber",
    };
};

pub const CarrierLookupOutput = struct {
    /// The carrier or service provider that the phone number is currently
    /// registered with. In some countries and regions, this value may be the
    /// carrier or service provider that the phone number was originally registered
    /// with.
    carrier: ?[]const u8 = null,

    /// The name of the country or region for the phone number.
    country: ?[]const u8 = null,

    /// The country or region numeric dialing code for the phone number.
    dialing_country_code: ?[]const u8 = null,

    /// The phone number in E164 format, sanitized from the original input by
    /// removing any formatting characters.
    e164_phone_number: []const u8,

    /// The two-character country or region code, in ISO 3166-1 alpha-2 format, for
    /// the phone number.
    iso_country_code: ?[]const u8 = null,

    /// The phone number's mobile country code, for mobile phone number types
    mcc: ?[]const u8 = null,

    /// The phone number's mobile network code, for mobile phone number types.
    mnc: ?[]const u8 = null,

    /// Describes the type of phone number. Valid values are: MOBILE, LANDLINE,
    /// OTHER, and INVALID. Avoid sending SMS or voice messages to INVALID phone
    /// numbers, as these numbers are unlikely to belong to actual recipients.
    phone_number_type: PhoneNumberType,

    pub const json_field_names = .{
        .carrier = "Carrier",
        .country = "Country",
        .dialing_country_code = "DialingCountryCode",
        .e164_phone_number = "E164PhoneNumber",
        .iso_country_code = "IsoCountryCode",
        .mcc = "MCC",
        .mnc = "MNC",
        .phone_number_type = "PhoneNumberType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CarrierLookupInput, options: CallOptions) !CarrierLookupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CarrierLookupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.CarrierLookup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CarrierLookupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CarrierLookupOutput, body, allocator);
}
