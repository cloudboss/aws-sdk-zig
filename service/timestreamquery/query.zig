const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryInsights = @import("query_insights.zig").QueryInsights;
const ColumnInfo = @import("column_info.zig").ColumnInfo;
const QueryInsightsResponse = @import("query_insights_response.zig").QueryInsightsResponse;
const QueryStatus = @import("query_status.zig").QueryStatus;
const Row = @import("row.zig").Row;

pub const QueryInput = @import("query_request.zig").QueryRequest;

pub const QueryOutput = struct {
    /// The column data types of the returned result set.
    column_info: ?[]const ColumnInfo = null,

    /// A pagination token that can be used again on a `Query` call to get the
    /// next set of results.
    next_token: ?[]const u8 = null,

    /// A unique ID for the given query.
    query_id: []const u8,

    /// Encapsulates `QueryInsights` containing insights and metrics related to the
    /// query that you executed.
    query_insights_response: ?QueryInsightsResponse = null,

    /// Information about the status of the query, including progress and bytes
    /// scanned.
    query_status: ?QueryStatus = null,

    /// The result set rows returned by the query.
    rows: ?[]const Row = null,

    pub const json_field_names = .{
        .column_info = "ColumnInfo",
        .next_token = "NextToken",
        .query_id = "QueryId",
        .query_insights_response = "QueryInsightsResponse",
        .query_status = "QueryStatus",
        .rows = "Rows",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QueryInput, options: CallOptions) !QueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: QueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("query.timestream", "Timestream Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.Query");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !QueryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(QueryOutput, body, allocator);
}
