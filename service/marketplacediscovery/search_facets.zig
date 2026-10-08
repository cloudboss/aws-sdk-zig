const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchFacetType = @import("search_facet_type.zig").SearchFacetType;
const SearchFilter = @import("search_filter.zig").SearchFilter;
const ListingFacet = @import("listing_facet.zig").ListingFacet;

pub const SearchFacetsInput = struct {
    /// A list of specific facet types to retrieve. If empty or null, all available
    /// facets are returned.
    facet_types: ?[]const SearchFacetType = null,

    /// Filters to apply before retrieving facets. Multiple filters are combined
    /// with AND logic. Multiple values within the same filter are combined with OR
    /// logic.
    filters: ?[]const SearchFilter = null,

    /// A BCP 47 language tag or comma-separated priority list specifying the
    /// preferred locale for response content. See `Locale` for supported values,
    /// constraints, fallback behavior, and the default locale. If omitted, the
    /// service returns content in the default locale.
    locale: ?[]const u8 = null,

    /// If `nextToken` is returned, there are more results available. Make the call
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The search query text to filter listings before retrieving facets.
    search_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .facet_types = "facetTypes",
        .filters = "filters",
        .locale = "locale",
        .next_token = "nextToken",
        .search_text = "searchText",
    };
};

pub const SearchFacetsOutput = struct {
    /// A map of facet types to their corresponding facet values. Each facet value
    /// includes a display name, internal value, and count of matching listings.
    listing_facets: ?[]const aws.map.MapEntry([]const ListingFacet) = null,

    /// If `nextToken` is returned, there are more results available. Make the call
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The total number of listings matching the search criteria.
    total_results: i64,

    pub const json_field_names = .{
        .listing_facets = "listingFacets",
        .next_token = "nextToken",
        .total_results = "totalResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchFacetsInput, options: CallOptions) !SearchFacetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchFacetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery-marketplace", "Marketplace Discovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2026-02-05/searchFacets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.facet_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"facetTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchFacetsOutput {
    const result: SearchFacetsOutput = try aws.json.parseJsonObject(
        SearchFacetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
