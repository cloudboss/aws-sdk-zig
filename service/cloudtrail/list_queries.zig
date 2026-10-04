const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryStatus = @import("query_status.zig").QueryStatus;
const Query = @import("query.zig").Query;

pub const ListQueriesInput = struct {
    /// Use with `StartTime` to bound a `ListQueries` request, and limit
    /// its results to only those queries run within a specified time period.
    end_time: ?i64 = null,

    /// The ARN (or the ID suffix of the ARN) of an event data store on which
    /// queries were
    /// run.
    event_data_store: []const u8,

    /// The maximum number of queries to show on a page.
    max_results: ?i32 = null,

    /// A token you can use to get the next page of results.
    next_token: ?[]const u8 = null,

    /// The status of queries that you want to return in results. Valid values for
    /// `QueryStatus` include `QUEUED`, `RUNNING`,
    /// `FINISHED`, `FAILED`, `TIMED_OUT`, or
    /// `CANCELLED`.
    query_status: ?QueryStatus = null,

    /// Use with `EndTime` to bound a `ListQueries` request, and limit its
    /// results to only those queries run within a specified time period.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .event_data_store = "EventDataStore",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .query_status = "QueryStatus",
        .start_time = "StartTime",
    };
};

pub const ListQueriesOutput = struct {
    /// A token you can use to get the next page of results.
    next_token: ?[]const u8 = null,

    /// Lists matching query results, and shows query ID, status, and creation time
    /// of each
    /// query.
    queries: ?[]const Query = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .queries = "Queries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListQueriesInput, options: CallOptions) !ListQueriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListQueriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.ListQueries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQueriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListQueriesOutput, body, allocator);
}
