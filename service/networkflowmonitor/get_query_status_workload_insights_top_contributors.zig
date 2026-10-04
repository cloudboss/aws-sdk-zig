const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryStatus = @import("query_status.zig").QueryStatus;

pub const GetQueryStatusWorkloadInsightsTopContributorsInput = struct {
    /// The identifier for the query. A query ID is an internally-generated
    /// identifier for a specific query returned from an API call to start a query.
    query_id: []const u8,

    /// The identifier for the scope that includes the resources you want to get
    /// data results for. A scope ID is an internally-generated identifier that
    /// includes all the resources for a specific root account.
    scope_id: []const u8,

    pub const json_field_names = .{
        .query_id = "queryId",
        .scope_id = "scopeId",
    };
};

pub const GetQueryStatusWorkloadInsightsTopContributorsOutput = struct {
    /// When you run a query, use this call to check the status of the query to make
    /// sure that the query has `SUCCEEDED` before you review the results.
    ///
    /// * `QUEUED`: The query is scheduled to run.
    /// * `RUNNING`: The query is in progress but not complete.
    /// * `SUCCEEDED`: The query completed sucessfully.
    /// * `FAILED`: The query failed due to an error.
    /// * `CANCELED`: The query was canceled.
    status: QueryStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueryStatusWorkloadInsightsTopContributorsInput, options: CallOptions) !GetQueryStatusWorkloadInsightsTopContributorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueryStatusWorkloadInsightsTopContributorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloadInsights/");
    try path_buf.appendSlice(allocator, input.scope_id);
    try path_buf.appendSlice(allocator, "/topContributorsQueries/");
    try path_buf.appendSlice(allocator, input.query_id);
    try path_buf.appendSlice(allocator, "/status");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueryStatusWorkloadInsightsTopContributorsOutput {
    var result: GetQueryStatusWorkloadInsightsTopContributorsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetQueryStatusWorkloadInsightsTopContributorsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
