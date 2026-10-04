const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListInsightsStatusFilter = @import("list_insights_status_filter.zig").ListInsightsStatusFilter;
const ProactiveOrganizationInsightSummary = @import("proactive_organization_insight_summary.zig").ProactiveOrganizationInsightSummary;
const ReactiveOrganizationInsightSummary = @import("reactive_organization_insight_summary.zig").ReactiveOrganizationInsightSummary;

pub const ListOrganizationInsightsInput = struct {
    /// The ID of the Amazon Web Services account.
    account_ids: ?[]const []const u8 = null,

    /// The maximum number of results to return with a single call.
    /// To retrieve the remaining results, make another call with the returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If this value is null, it
    /// retrieves the first page.
    next_token: ?[]const u8 = null,

    /// The ID of the organizational unit.
    organizational_unit_ids: ?[]const []const u8 = null,

    status_filter: ListInsightsStatusFilter,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .organizational_unit_ids = "OrganizationalUnitIds",
        .status_filter = "StatusFilter",
    };
};

pub const ListOrganizationInsightsOutput = struct {
    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If there are no more pages,
    /// this value is null.
    next_token: ?[]const u8 = null,

    /// An integer that specifies the number of open proactive insights in your
    /// Amazon Web Services
    /// account.
    proactive_insights: ?[]const ProactiveOrganizationInsightSummary = null,

    /// An integer that specifies the number of open reactive insights in your
    /// Amazon Web Services
    /// account.
    reactive_insights: ?[]const ReactiveOrganizationInsightSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .proactive_insights = "ProactiveInsights",
        .reactive_insights = "ReactiveInsights",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOrganizationInsightsInput, options: CallOptions) !ListOrganizationInsightsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOrganizationInsightsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/organization/insights";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountIds\":");
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
    if (input.organizational_unit_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrganizationalUnitIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StatusFilter\":");
    try aws.json.writeValue(@TypeOf(input.status_filter), input.status_filter, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOrganizationInsightsOutput {
    var result: ListOrganizationInsightsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListOrganizationInsightsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
