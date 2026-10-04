const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryLanguage = @import("query_language.zig").QueryLanguage;
const QueryStatus = @import("query_status.zig").QueryStatus;
const QueryInfo = @import("query_info.zig").QueryInfo;

pub const DescribeQueriesInput = struct {
    /// Limits the returned queries to only those for the specified log group.
    log_group_name: ?[]const u8 = null,

    /// Limits the number of returned queries to the specified number.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// Limits the returned queries to only the queries that use the specified query
    /// language.
    query_language: ?QueryLanguage = null,

    /// Limits the returned queries to only those that have the specified status.
    /// Valid values are
    /// `Cancelled`, `Complete`, `Failed`, `Running`,
    /// and `Scheduled`.
    status: ?QueryStatus = null,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .query_language = "queryLanguage",
        .status = "status",
    };
};

pub const DescribeQueriesOutput = struct {
    next_token: ?[]const u8 = null,

    /// The list of queries that match the request.
    queries: ?[]const QueryInfo = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .queries = "queries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeQueriesInput, options: CallOptions) !DescribeQueriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeQueriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeQueries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeQueriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeQueriesOutput, body, allocator);
}
