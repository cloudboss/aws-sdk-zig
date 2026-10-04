const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PhoneNumberAssociationName = @import("phone_number_association_name.zig").PhoneNumberAssociationName;
const PhoneNumberProductType = @import("phone_number_product_type.zig").PhoneNumberProductType;
const PhoneNumber = @import("phone_number.zig").PhoneNumber;

pub const ListPhoneNumbersInput = struct {
    /// The filter to limit the number of results.
    filter_name: ?PhoneNumberAssociationName = null,

    /// The filter value.
    filter_value: ?[]const u8 = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The token used to return the next page of results.
    next_token: ?[]const u8 = null,

    /// The phone number product types.
    product_type: ?PhoneNumberProductType = null,

    /// The status of your organization's phone numbers.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_name = "FilterName",
        .filter_value = "FilterValue",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .product_type = "ProductType",
        .status = "Status",
    };
};

pub const ListPhoneNumbersOutput = struct {
    /// The token used to return the next page of results.
    next_token: ?[]const u8 = null,

    /// The phone number details.
    phone_numbers: ?[]const PhoneNumber = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .phone_numbers = "PhoneNumbers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPhoneNumbersInput, options: CallOptions) !ListPhoneNumbersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPhoneNumbersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/phone-numbers";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.filter_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "filter-name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.filter_value) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "filter-value=");
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
    if (input.product_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "product-type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPhoneNumbersOutput {
    var result: ListPhoneNumbersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPhoneNumbersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
