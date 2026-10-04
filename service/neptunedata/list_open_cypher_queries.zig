const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GremlinQueryStatus = @import("gremlin_query_status.zig").GremlinQueryStatus;

pub const ListOpenCypherQueriesInput = struct {
    /// When set to `TRUE` and other parameters are not present, causes status
    /// information to be returned for waiting queries as well as for running
    /// queries.
    include_waiting: ?bool = null,

    pub const json_field_names = .{
        .include_waiting = "includeWaiting",
    };
};

pub const ListOpenCypherQueriesOutput = struct {
    /// The number of queries that have been accepted but not yet completed,
    /// including queries in the queue.
    accepted_query_count: ?i32 = null,

    /// A list of current openCypher queries.
    queries: ?[]const GremlinQueryStatus = null,

    /// The number of currently running openCypher queries.
    running_query_count: ?i32 = null,

    pub const json_field_names = .{
        .accepted_query_count = "acceptedQueryCount",
        .queries = "queries",
        .running_query_count = "runningQueryCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOpenCypherQueriesInput, options: CallOptions) !ListOpenCypherQueriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-db", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOpenCypherQueriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/opencypher/status";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_waiting) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeWaiting=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOpenCypherQueriesOutput {
    const result: ListOpenCypherQueriesOutput = try aws.json.parseJsonObject(
        ListOpenCypherQueriesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
