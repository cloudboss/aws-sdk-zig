const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchFilter = @import("search_filter.zig").SearchFilter;
const SearchListingsSortBy = @import("search_listings_sort_by.zig").SearchListingsSortBy;
const SearchListingsSortOrder = @import("search_listings_sort_order.zig").SearchListingsSortOrder;
const ListingSummary = @import("listing_summary.zig").ListingSummary;

pub const SearchListingsInput = struct {
    /// Filters to narrow search results. Multiple filters are combined with AND
    /// logic. Multiple values within the same filter are combined with OR logic.
    filters: ?[]const SearchFilter = null,

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

    /// The search query text to find relevant listings.
    search_text: ?[]const u8 = null,

    /// The field to sort results by. Valid values are `RELEVANCE` and
    /// `AVERAGE_CUSTOMER_RATING`.
    sort_by: ?SearchListingsSortBy = null,

    /// The sort direction. Valid values are `DESCENDING` and `ASCENDING`.
    sort_order: ?SearchListingsSortOrder = null,

    pub const json_field_names = .{
        .filters = "filters",
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .search_text = "searchText",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const SearchListingsOutput = struct {
    /// The listing summaries matching the search criteria. Each summary includes
    /// the listing name, description, badges, categories, pricing models, reviews,
    /// and associated products.
    listing_summaries: ?[]const ListingSummary = null,

    /// If `nextToken` is returned, there are more results available. Make the call
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The total number of listings matching the search criteria.
    total_results: i64,

    pub const json_field_names = .{
        .listing_summaries = "listingSummaries",
        .next_token = "nextToken",
        .total_results = "totalResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchListingsInput, options: CallOptions) !SearchListingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchListingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery-marketplace", "Marketplace Discovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2026-02-05/searchListings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.search_text) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"searchText\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortOrder\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchListingsOutput {
    const result: SearchListingsOutput = try aws.json.parseJsonObject(
        SearchListingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
