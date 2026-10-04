const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryStateInput = @import("query_state_input.zig").QueryStateInput;
const QuerySummary = @import("query_summary.zig").QuerySummary;

pub const ListQueriesInput = struct {
    /// The unique identifier of the Neptune Analytics graph.
    graph_identifier: []const u8,

    /// The maximum number of results to be fetched by the API.
    max_results: i32,

    /// Filtered list of queries based on state.
    state: ?QueryStateInput = null,

    pub const json_field_names = .{
        .graph_identifier = "graphIdentifier",
        .max_results = "maxResults",
        .state = "state",
    };
};

pub const ListQueriesOutput = struct {
    /// A list of current openCypher queries.
    queries: ?[]const QuerySummary = null,

    pub const json_field_names = .{
        .queries = "queries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListQueriesInput, options: CallOptions) !ListQueriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-graph", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/queries";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "maxResults=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.max_results}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "state=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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
    try request.headers.put(allocator, "graphIdentifier", input.graph_identifier);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQueriesOutput {
    const result: ListQueriesOutput = try aws.json.parseJsonObject(
        ListQueriesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
