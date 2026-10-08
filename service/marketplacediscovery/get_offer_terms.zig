const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OfferTerm = @import("offer_term.zig").OfferTerm;

pub const GetOfferTermsInput = struct {
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

    /// The unique identifier of the offer whose terms to retrieve.
    offer_id: []const u8,

    pub const json_field_names = .{
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .offer_id = "offerId",
    };
};

pub const GetOfferTermsOutput = struct {
    /// The locale of the returned content. Indicates whether the response contains
    /// content in the requested locale, or fell back to the default locale. See
    /// `Locale` for details.
    locale: ?[]const u8 = null,

    /// If `nextToken` is returned, there are more results available. Make the call
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The terms attached to the offer. Each element contains exactly one term
    /// type.
    offer_terms: ?[]const OfferTerm = null,

    pub const json_field_names = .{
        .locale = "locale",
        .next_token = "nextToken",
        .offer_terms = "offerTerms",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOfferTermsInput, options: CallOptions) !GetOfferTermsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOfferTermsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery-marketplace", "Marketplace Discovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2026-02-05/getOfferTerms";

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
    try body_buf.appendSlice(allocator, "\"offerId\":");
    try aws.json.writeValue(@TypeOf(input.offer_id), input.offer_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOfferTermsOutput {
    const result: GetOfferTermsOutput = try aws.json.parseJsonObject(
        GetOfferTermsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
