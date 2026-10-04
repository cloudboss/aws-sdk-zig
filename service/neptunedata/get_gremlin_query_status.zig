const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryEvalStats = @import("query_eval_stats.zig").QueryEvalStats;

pub const GetGremlinQueryStatusInput = struct {
    /// The unique identifier that identifies the Gremlin query.
    query_id: []const u8,

    pub const json_field_names = .{
        .query_id = "queryId",
    };
};

pub const GetGremlinQueryStatusOutput = struct {
    /// The evaluation status of the Gremlin query.
    query_eval_stats: ?QueryEvalStats = null,

    /// The ID of the query for which status is being returned.
    query_id: ?[]const u8 = null,

    /// The Gremlin query string.
    query_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .query_eval_stats = "queryEvalStats",
        .query_id = "queryId",
        .query_string = "queryString",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGremlinQueryStatusInput, options: CallOptions) !GetGremlinQueryStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGremlinQueryStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gremlin/status/");
    try path_buf.appendSlice(allocator, input.query_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGremlinQueryStatusOutput {
    var result: GetGremlinQueryStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetGremlinQueryStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
