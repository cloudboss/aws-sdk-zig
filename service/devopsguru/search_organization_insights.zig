const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchOrganizationInsightsFilters = @import("search_organization_insights_filters.zig").SearchOrganizationInsightsFilters;
const StartTimeRange = @import("start_time_range.zig").StartTimeRange;
const InsightType = @import("insight_type.zig").InsightType;
const ProactiveInsightSummary = @import("proactive_insight_summary.zig").ProactiveInsightSummary;
const ReactiveInsightSummary = @import("reactive_insight_summary.zig").ReactiveInsightSummary;

pub const SearchOrganizationInsightsInput = struct {
    /// The ID of the Amazon Web Services account.
    account_ids: []const []const u8,

    /// A `SearchOrganizationInsightsFilters` object that is used to set the
    /// severity and status filters on your insight search.
    filters: ?SearchOrganizationInsightsFilters = null,

    /// The maximum number of results to return with a single call.
    /// To retrieve the remaining results, make another call with the returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If this value is null, it
    /// retrieves the first page.
    next_token: ?[]const u8 = null,

    start_time_range: StartTimeRange,

    /// The type of insights you are searching for (`REACTIVE` or
    /// `PROACTIVE`).
    @"type": InsightType,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_time_range = "StartTimeRange",
        .@"type" = "Type",
    };
};

pub const SearchOrganizationInsightsOutput = struct {
    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If there are no more pages,
    /// this value is null.
    next_token: ?[]const u8 = null,

    /// An integer that specifies the number of open proactive insights in your
    /// Amazon Web Services
    /// account.
    proactive_insights: ?[]const ProactiveInsightSummary = null,

    /// An integer that specifies the number of open reactive insights in your
    /// Amazon Web Services
    /// account.
    reactive_insights: ?[]const ReactiveInsightSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .proactive_insights = "ProactiveInsights",
        .reactive_insights = "ReactiveInsights",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchOrganizationInsightsInput, options: CallOptions) !SearchOrganizationInsightsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchOrganizationInsightsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/organization/insights/search";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AccountIds\":");
    try aws.json.writeValue(@TypeOf(input.account_ids), input.account_ids, allocator, &body_buf);
    has_prev = true;
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTimeRange\":");
    try aws.json.writeValue(@TypeOf(input.start_time_range), input.start_time_range, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchOrganizationInsightsOutput {
    const result: SearchOrganizationInsightsOutput = try aws.json.parseJsonObject(
        SearchOrganizationInsightsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
