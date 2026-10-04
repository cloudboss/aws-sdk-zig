const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchOutputAdditionalAttribute = @import("search_output_additional_attribute.zig").SearchOutputAdditionalAttribute;
const AggregationListItem = @import("aggregation_list_item.zig").AggregationListItem;
const FilterClause = @import("filter_clause.zig").FilterClause;
const SearchInItem = @import("search_in_item.zig").SearchInItem;
const SearchSort = @import("search_sort.zig").SearchSort;
const AggregationOutput = @import("aggregation_output.zig").AggregationOutput;
const SearchResultItem = @import("search_result_item.zig").SearchResultItem;

pub const SearchListingsInput = struct {
    /// Specifies additional attributes for the search.
    additional_attributes: ?[]const SearchOutputAdditionalAttribute = null,

    /// Enables you to specify one or more attributes to compute and return counts
    /// grouped by field values.
    aggregations: ?[]const AggregationListItem = null,

    /// The identifier of the domain in which to search listings.
    domain_identifier: []const u8,

    /// Specifies the filters for the search of listings.
    filters: ?FilterClause = null,

    /// The maximum number of results to return in a single call to
    /// `SearchListings`. When the number of results to be listed is greater than
    /// the value of `MaxResults`, the response contains a `NextToken` value that
    /// you can use in a subsequent call to `SearchListings` to list the next set of
    /// results.
    max_results: ?i32 = null,

    /// When the number of results is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of results, the response includes
    /// a pagination token named `NextToken`. You can specify this `NextToken` value
    /// in a subsequent call to `SearchListings` to list the next set of results.
    next_token: ?[]const u8 = null,

    /// The details of the search.
    search_in: ?[]const SearchInItem = null,

    /// Specifies the text for which to search.
    search_text: ?[]const u8 = null,

    /// Specifies the way for sorting the search results.
    sort: ?SearchSort = null,

    pub const json_field_names = .{
        .additional_attributes = "additionalAttributes",
        .aggregations = "aggregations",
        .domain_identifier = "domainIdentifier",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .search_in = "searchIn",
        .search_text = "searchText",
        .sort = "sort",
    };
};

pub const SearchListingsOutput = struct {
    /// Contains computed counts grouped by field values based on the requested
    /// aggregation attributes for the matching listings.
    aggregates: ?[]const AggregationOutput = null,

    /// The results of the `SearchListings` action.
    items: ?[]const SearchResultItem = null,

    /// When the number of results is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of results, the response includes
    /// a pagination token named `NextToken`. You can specify this `NextToken` value
    /// in a subsequent call to `SearchListings` to list the next set of results.
    next_token: ?[]const u8 = null,

    /// Total number of search results.
    total_match_count: ?i32 = null,

    pub const json_field_names = .{
        .aggregates = "aggregates",
        .items = "items",
        .next_token = "nextToken",
        .total_match_count = "totalMatchCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchListingsInput, options: CallOptions) !SearchListingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/listings/search");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.aggregations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"aggregations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
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
    if (input.search_in) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"searchIn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.search_text) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"searchText\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sort\":");
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
