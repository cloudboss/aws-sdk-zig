const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;

pub const SearchAvailablePhoneNumbersInput = struct {
    /// The area code used to filter results. Only applies to the US.
    area_code: ?[]const u8 = null,

    /// The city used to filter results. Only applies to the US.
    city: ?[]const u8 = null,

    /// The country used to filter results. Defaults to the US Format: ISO 3166-1
    /// alpha-2.
    country: ?[]const u8 = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The token used to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The phone number type used to filter results. Required for non-US numbers.
    phone_number_type: ?PhoneNumberType = null,

    /// The state used to filter results. Required only if you provide `City`. Only
    /// applies to the US.
    state: ?[]const u8 = null,

    /// The toll-free prefix that you use to filter results. Only applies to the US.
    toll_free_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .area_code = "AreaCode",
        .city = "City",
        .country = "Country",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .phone_number_type = "PhoneNumberType",
        .state = "State",
        .toll_free_prefix = "TollFreePrefix",
    };
};

pub const SearchAvailablePhoneNumbersOutput = struct {
    /// List of phone numbers, in E.164 format.
    e164_phone_numbers: ?[]const []const u8 = null,

    /// The token used to retrieve the next page of search results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .e164_phone_numbers = "E164PhoneNumbers",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchAvailablePhoneNumbersInput, options: CallOptions) !SearchAvailablePhoneNumbersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchAvailablePhoneNumbersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chime", "Chime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/search";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "type=phone-numbers");
    query_has_prev = true;
    if (input.area_code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "area-code=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.city) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "city=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.country) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "country=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.phone_number_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "phone-number-type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "state=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.toll_free_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "toll-free-prefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchAvailablePhoneNumbersOutput {
    const result: SearchAvailablePhoneNumbersOutput = try aws.json.parseJsonObject(
        SearchAvailablePhoneNumbersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
