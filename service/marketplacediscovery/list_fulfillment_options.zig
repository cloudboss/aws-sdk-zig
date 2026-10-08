const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FulfillmentOption = @import("fulfillment_option.zig").FulfillmentOption;

pub const ListFulfillmentOptionsInput = struct {
    /// A BCP 47 language tag or comma-separated priority list specifying the
    /// preferred locale for response content. See `Locale` for supported values,
    /// constraints, fallback behavior, and the default locale. If omitted, the
    /// service returns content in the default locale.
    locale: ?[]const u8 = null,

    /// The maximum number of results that are returned per call. You can use
    /// `nextToken` to get more results.
    max_results: ?i32 = null,

    /// If `nextToken` is returned, there are more results available. Make the call
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the product for which to list fulfillment options.
    product_id: []const u8,

    pub const json_field_names = .{
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .product_id = "productId",
    };
};

pub const ListFulfillmentOptionsOutput = struct {
    /// The fulfillment options available for the product. Each option describes how
    /// the buyer can deploy or access the product.
    fulfillment_options: ?[]const FulfillmentOption = null,

    locale: ?[]const u8 = null,

    /// If `nextToken` is returned, there are more results available. Make the call
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .fulfillment_options = "fulfillmentOptions",
        .locale = "locale",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFulfillmentOptionsInput, options: CallOptions) !ListFulfillmentOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFulfillmentOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery-marketplace", "Marketplace Discovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2026-02-05/listFulfillmentOptions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.locale) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"locale\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"productId\":");
    try aws.json.writeValue(@TypeOf(input.product_id), input.product_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFulfillmentOptionsOutput {
    const result: ListFulfillmentOptionsOutput = try aws.json.parseJsonObject(
        ListFulfillmentOptionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
