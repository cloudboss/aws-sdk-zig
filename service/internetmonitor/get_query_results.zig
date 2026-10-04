const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryField = @import("query_field.zig").QueryField;

pub const GetQueryResultsInput = struct {
    /// The number of query results that you want to return with this call.
    max_results: ?i32 = null,

    /// The name of the monitor to return data for.
    monitor_name: []const u8,

    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    /// The ID of the query that you want to return data results for. A `QueryId` is
    /// an
    /// internally-generated identifier for a specific query.
    query_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .monitor_name = "MonitorName",
        .next_token = "NextToken",
        .query_id = "QueryId",
    };
};

pub const GetQueryResultsOutput = struct {
    /// The data results that the query returns. Data is returned in arrays, aligned
    /// with the `Fields`
    /// for the query, which creates a repository of Amazon CloudWatch Internet
    /// Monitor information for your application. Then, you can filter
    /// the information in the repository by using `FilterParameters` that you
    /// define.
    data: ?[]const []const []const u8 = null,

    /// The fields that the query returns data for. Fields are name-data type pairs,
    /// such as
    /// `availability_score`-`float`.
    fields: ?[]const QueryField = null,

    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "Data",
        .fields = "Fields",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueryResultsInput, options: CallOptions) !GetQueryResultsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "internetmonitor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueryResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("internetmonitor", "InternetMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20210603/Monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    try path_buf.appendSlice(allocator, "/Queries/");
    try path_buf.appendSlice(allocator, input.query_id);
    try path_buf.appendSlice(allocator, "/Results");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueryResultsOutput {
    const result: GetQueryResultsOutput = try aws.json.parseJsonObject(
        GetQueryResultsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
