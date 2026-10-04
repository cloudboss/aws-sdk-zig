const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberProductType = @import("phone_number_product_type.zig").PhoneNumberProductType;
const PhoneNumberCountry = @import("phone_number_country.zig").PhoneNumberCountry;

pub const ListSupportedPhoneNumberCountriesInput = struct {
    /// The phone number product type.
    product_type: PhoneNumberProductType,

    pub const json_field_names = .{
        .product_type = "ProductType",
    };
};

pub const ListSupportedPhoneNumberCountriesOutput = struct {
    /// The supported phone number countries.
    phone_number_countries: ?[]const PhoneNumberCountry = null,

    pub const json_field_names = .{
        .phone_number_countries = "PhoneNumberCountries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSupportedPhoneNumberCountriesInput, options: CallOptions) !ListSupportedPhoneNumberCountriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSupportedPhoneNumberCountriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chime", "Chime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/phone-number-countries";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "product-type=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.product_type.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSupportedPhoneNumberCountriesOutput {
    const result: ListSupportedPhoneNumberCountriesOutput = try aws.json.parseJsonObject(
        ListSupportedPhoneNumberCountriesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
