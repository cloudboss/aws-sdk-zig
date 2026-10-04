const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchSpendingLimitsFilter = @import("search_spending_limits_filter.zig").SearchSpendingLimitsFilter;
const SpendingLimitSummary = @import("spending_limit_summary.zig").SpendingLimitSummary;

pub const SearchSpendingLimitsInput = struct {
    /// The filters to apply when searching for spending limits. Use filters to
    /// narrow down the results based on specific criteria.
    filters: ?[]const SearchSpendingLimitsFilter = null,

    /// The maximum number of results to return in a single call. Minimum value of
    /// 1, maximum value of 100. Default is 20.
    max_results: ?i32 = null,

    /// The token to retrieve the next page of results. This value is returned from
    /// a previous call to SearchSpendingLimits when there are more results
    /// available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const SearchSpendingLimitsOutput = struct {
    /// The token to retrieve the next page of results. This value is null when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    /// An array of spending limit summaries that match the specified filters.
    spending_limits: ?[]const SpendingLimitSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .spending_limits = "spendingLimits",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchSpendingLimitsInput, options: CallOptions) !SearchSpendingLimitsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "braket", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchSpendingLimitsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("braket", "Braket", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/spending-limits";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchSpendingLimitsOutput {
    var result: SearchSpendingLimitsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchSpendingLimitsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
