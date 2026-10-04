const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkloadInsightsTopContributorsRow = @import("workload_insights_top_contributors_row.zig").WorkloadInsightsTopContributorsRow;

pub const GetQueryResultsWorkloadInsightsTopContributorsInput = struct {
    /// The number of query results that you want to return with this call.
    max_results: ?i32 = null,

    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    /// The identifier for the query. A query ID is an internally-generated
    /// identifier for a specific query returned from an API call to create a query.
    query_id: []const u8,

    /// The identifier for the scope that includes the resources you want to get
    /// data results for. A scope ID is an internally-generated identifier that
    /// includes all the resources for a specific root account.
    scope_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .query_id = "queryId",
        .scope_id = "scopeId",
    };
};

pub const GetQueryResultsWorkloadInsightsTopContributorsOutput = struct {
    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    /// The top contributor network flows overall for a specific metric type, for
    /// example, the number of retransmissions.
    top_contributors: ?[]const WorkloadInsightsTopContributorsRow = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .top_contributors = "topContributors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueryResultsWorkloadInsightsTopContributorsInput, options: CallOptions) !GetQueryResultsWorkloadInsightsTopContributorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkflowmonitor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueryResultsWorkloadInsightsTopContributorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloadInsights/");
    try path_buf.appendSlice(allocator, input.scope_id);
    try path_buf.appendSlice(allocator, "/topContributorsQueries/");
    try path_buf.appendSlice(allocator, input.query_id);
    try path_buf.appendSlice(allocator, "/results");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueryResultsWorkloadInsightsTopContributorsOutput {
    const result: GetQueryResultsWorkloadInsightsTopContributorsOutput = try aws.json.parseJsonObject(
        GetQueryResultsWorkloadInsightsTopContributorsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
