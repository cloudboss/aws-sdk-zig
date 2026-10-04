const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SavingsPlanRateFilter = @import("savings_plan_rate_filter.zig").SavingsPlanRateFilter;
const SavingsPlanRate = @import("savings_plan_rate.zig").SavingsPlanRate;

pub const DescribeSavingsPlanRatesInput = struct {
    /// The filters.
    filters: ?[]const SavingsPlanRateFilter = null,

    /// The maximum number of results to return with a single call. To retrieve
    /// additional
    /// results, make another call with the returned token value.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The ID of the Savings Plan.
    savings_plan_id: []const u8,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .savings_plan_id = "savingsPlanId",
    };
};

pub const DescribeSavingsPlanRatesOutput = struct {
    /// The token to use to retrieve the next page of results. This value is null
    /// when there are
    /// no more results to return.
    next_token: ?[]const u8 = null,

    /// The ID of the Savings Plan.
    savings_plan_id: ?[]const u8 = null,

    /// Information about the Savings Plan rates.
    search_results: ?[]const SavingsPlanRate = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .savings_plan_id = "savingsPlanId",
        .search_results = "searchResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSavingsPlanRatesInput, options: CallOptions) !DescribeSavingsPlanRatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "savingsplans", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSavingsPlanRatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("savingsplans", "savingsplans", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DescribeSavingsPlanRates";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"savingsPlanId\":");
    try aws.json.writeValue(@TypeOf(input.savings_plan_id), input.savings_plan_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSavingsPlanRatesOutput {
    var result: DescribeSavingsPlanRatesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeSavingsPlanRatesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
