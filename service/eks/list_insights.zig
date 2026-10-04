const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightsFilter = @import("insights_filter.zig").InsightsFilter;
const InsightSummary = @import("insight_summary.zig").InsightSummary;

pub const ListInsightsInput = struct {
    /// The name of the Amazon EKS cluster associated with the insights.
    cluster_name: []const u8,

    /// The criteria to filter your list of insights for your cluster. You can
    /// filter which
    /// insights are returned by category, associated Kubernetes version, and
    /// status.
    filter: ?InsightsFilter = null,

    /// The maximum number of identity provider configurations returned by
    /// `ListInsights` in paginated output. When you use this parameter,
    /// `ListInsights` returns only `maxResults` results in a single
    /// page along with a `nextToken` response element. You can see the remaining
    /// results of the initial request by sending another `ListInsights` request
    /// with
    /// the returned `nextToken` value. This value can be between 1
    /// and 100. If you don't use this parameter, `ListInsights`
    /// returns up to 100 results and a `nextToken` value, if
    /// applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListInsights` request. When the results of a `ListInsights`
    /// request exceed `maxResults`, you can use this value to retrieve the next
    /// page
    /// of results. This value is `null` when there are no more results to
    /// return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListInsightsOutput = struct {
    /// The returned list of insights.
    insights: ?[]const InsightSummary = null,

    /// The `nextToken` value to include in a future `ListInsights`
    /// request. When the results of a `ListInsights` request exceed
    /// `maxResults`, you can use this value to retrieve the next page of
    /// results. This value is `null` when there are no more results to
    /// return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .insights = "insights",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInsightsInput, options: CallOptions) !ListInsightsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInsightsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/insights");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filter\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInsightsOutput {
    const result: ListInsightsOutput = try aws.json.parseJsonObject(
        ListInsightsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
